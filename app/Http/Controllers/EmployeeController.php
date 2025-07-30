<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Company;
use App\Models\Employee;

use App\Models\Transaction;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use App\Models\EmployeeProduct;
use App\Exports\ExportEmployees;
use App\Imports\ImportEmployees;
use Illuminate\Support\Facades\DB;

use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str; // Top par add karein agar nahi kiya


class EmployeeController extends Controller
{
    //
    use ApiResponse;

    public function create(Request $request)
    {
        try {
            $request->validate([
                'username' => 'required',
                'email' => 'required|email|unique:users,email',
                'phone' => 'required',
                'password' => 'required',
                'designation' => 'required',
            ]);

            DB::beginTransaction();

            $CompanyId = auth('sanctum')->user()->company_id;
            $companyData = Company::findOrFail($CompanyId);

            // Validate: Only one deal type should be active
            if ($companyData->is_benefit_amount_deal && $companyData->is_free_order_deal) {
                return $this->errorResponse(['model' => 'employee'], 'Company has both deal types enabled. Only one can be active.', [], 422);
            }

            // Initialize default values
            $isBenefitDeal = 0;
            $isFreeOrderDeal = 0;
            $benefitAmount = 0;
            $freeOrderLimit = 0;
            $startingDate = null;
            $endingDate = null;

            if ($companyData->is_benefit_amount_deal == 1) {
                $isBenefitDeal = 1;
                $benefitAmount = $companyData->globel_amount;
                $startingDate = $companyData->starting_date;
                $endingDate = $companyData->ending_date;
            }

            if ($companyData->is_free_order_deal == 1) {
                $isFreeOrderDeal = 1;
                $freeOrderLimit = $companyData->global_free_order_limit;
                $startingDate = $companyData->starting_date;
                $endingDate = $companyData->ending_date;
            }

            // Create employee
            $employee = Employee::create([
                'designation' => $request->designation,
                'status' => $request->status ?? '',
                'phone' => $request->phone,
                'is_benefit_amount_deal' => $isBenefitDeal,
                'benefit_amount' => $benefitAmount,
                'is_free_order_deal' => $isFreeOrderDeal,
                'free_order_limit' => $freeOrderLimit,
                'starting_date' => $startingDate,
                'ending_date' => $endingDate,
                'company_id' => $CompanyId,
            ]);

            // Create user account for employee
            User::create([
                'name' => $request->username,
                'email' => $request->email,
                'role' => 'employee',
                'company_id' => $CompanyId,
                'employee_id' => $employee->id,
                'verification_number' => Str::uuid(),
                'password' => Hash::make($request->password),
            ]);

            // Create transaction if benefit deal is active
            if ($isBenefitDeal && $benefitAmount > 0) {
                Transaction::create([
                    'employee_id' => $employee->id,
                    'transaction_type' => 'credit',
                    'amount' => $benefitAmount,
                    'balance' => $benefitAmount,
                    'description' => 'This is the benefit amount that the employee received upon registration',
                ]);
            }

            DB::commit();

            return $this->successResponse(['model' => 'employee'], 'Employee created successfully', [
                'employee' => $employee,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'employee'], $e->getMessage(), [], 422);
        }
    }


    public function update(Request $request)
    {
        try {
            $request->validate([
                'username' => 'required',
                'email' => 'required',
                'designation' => 'required',
                'employee_id' => 'required',
                'status' => 'required|in:0,1', // Correct syntax for in rule

            ]);
            DB::beginTransaction();

            $employee = Employee::findOrFail($request->employee_id);
            $user = User::where('employee_id', $request->employee_id)->where('role', 'employee')->firstOrFail();

            $employee->update([
                'designation' => $request->designation     ?? '',
                // 'status' => $request->status  ?? '',
                'phone' => $request->phone ?? '',
            ]);

            $user->update([
                'name' => $request->username,
                'email' => $request->email,
                'password' => $request->password ? Hash::make($request->password) : $user->password,
                'status' => $request->status,
            ]);

            DB::commit();

            return $this->successResponse(['model' => 'employee'], 'Employee updated successfully', [
                'employee' => $employee,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'employee'], $e->getMessage(), [], 422);
        }
    }

    public function delete($employeeId)
    {
        try {
            DB::beginTransaction();
            $employee = Employee::findOrFail($employeeId);
            $user = User::where('employee_id', $employeeId)->firstOrFail();
            $user->delete();
            $employee->delete();
            DB::commit();
            return $this->successResponse(['model' => 'company'], 'Employee deleted successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'company'], $e->getMessage(), [], 422);
        }
    }


    public function getEmployee($employeeId)
    {
        try {

            $employee = DB::table('employees')
                ->join('users', 'employees.id', '=', 'users.employee_id')
                ->where('employees.id', $employeeId)
                ->where('employees.company_id', auth('sanctum')->user()->company_id)
                ->select('employees.*', 'users.name as username', 'users.email')
                ->first();

            if (!$employee) {
                return $this->errorResponse(['model' => 'employee'], 'employee not found', [], 404);
            }

            return $this->successResponse(['model' => 'employee'], 'employee retrieved successfully', [
                'employee' => $employee,
            ]);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'employee'], $e->getMessage(), [], 422);
        }
    }

    public function getAll()
    {
        try {
            $companyId = auth('sanctum')->user()->company_id;

            $employees = DB::table('employees')
                ->join('users as u1', 'employees.id', '=', 'u1.employee_id')
                ->join('companies as u2', 'employees.company_id', '=', 'u2.id')
                ->select('employees.*', 'u1.name as employeename', 'u1.status', 'u1.email', 'u2.company_name as companyname')
                ->when($companyId, function ($query, $companyId) {
                    return $query->where('employees.company_id', $companyId);
                })
                ->get();
            if ($employees->isEmpty()) {
                return $this->errorResponse(['model' => 'employee'], 'No employees found', [], 404);
            }

            return $this->successResponse(['model' => 'employee'], 'employees retrieved successfully', [
                'employees' => $employees,
            ]);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'employee'], $e->getMessage(), [], 422);
        }
    }




    public function downloadSample()
    {
        $fileName = 'employee_sample.xlsx';
        return Excel::download(new ExportEmployees, $fileName);
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:csv,txt',
        ]);

        try {
            $import = new ImportEmployees();
            Excel::import($import, $request->file('file'));

            $errors = $import->getErrors();

            if (!empty($errors)) {
                return $this->errorResponse(
                    ['model' => 'employee_import'],
                    'Some rows failed to import.',
                    $errors,
                    422
                );
            }

            return $this->successResponse(['model' => 'employee_import'], 'Employees imported successfully', []);
        } catch (\Exception $e) {
            return $this->errorResponse(
                ['model' => 'employee_import'],
                'Import failed due to an unexpected error.',
                [$e->getMessage()],
                422
            );
        }
    }

    // public function bulkUpdate(Request $request)
    // {
    //     $data = $request->validate([
    //         'employee_id' => 'required|array',
    //         'employee_id.*' => 'exists:employees,id',
    //         'starting_date' => 'nullable|date',
    //         'ending_date' => 'nullable|date|after_or_equal:starting_date',
    //     ]);

    //     try {
    //         DB::beginTransaction();

    //         $transactions = [];

    //         foreach ($data['employee_id'] as $employeeId) {
    //             $employee = Employee::findOrFail($employeeId);
    //             $company = Company::findOrFail($employee->company_id);

    //             $amount = $company->globel_amount;
    //             $type = 'credit';


    //             $employee->benefit_amount = $amount;

    //             // Optionally update dates
    //             if (isset($data['starting_date'])) {
    //                 $employee->starting_date = $data['starting_date'];
    //             }
    //             if (isset($data['ending_date'])) {
    //                 $employee->ending_date = $data['ending_date'];
    //             }

    //             $employee->save();

    //             // Create transaction
    //             $transaction = Transaction::create([
    //                 'employee_id' => $employee->id,
    //                 'amount' => $amount,
    //                 'balance' => $employee->benefit_amount,
    //                 'transaction_type' => $type,
    //             ]);

    //             $transactions[] = [
    //                 'employee_id' => $employee->id,
    //                 'transaction_id' => $transaction->id,
    //                 'status' => 'success',
    //             ];
    //         }

    //         DB::commit();

    //         return $this->successResponse(['model' => 'employee'], 'Benefits amount assigned successfully', [
    //             'transactions' => $transactions,
    //         ]);
    //     } catch (\Exception $e) {
    //         DB::rollBack();
    //         return $this->errorResponse(['model' => 'employee'], $e->getMessage(), [], 424);
    //     }
    // }

    public function bulkUpdate(Request $request)
    {
        $data = $request->validate([
            'employee_id' => 'required|array',
            'employee_id.*' => 'exists:employees,id',
            'starting_date' => 'nullable|date',
            'ending_date' => 'nullable|date|after_or_equal:starting_date',
        ]);

        try {
            DB::beginTransaction();

            $transactions = [];

            foreach ($data['employee_id'] as $employeeId) {
                $employee = Employee::findOrFail($employeeId);
                $company = Company::findOrFail($employee->company_id);

                // Check if company has valid deal type
                if ($company->is_benefit_amount_deal && $company->is_free_order_deal) {
                    return $this->errorResponse(['model' => 'employee'], 'Company has both deal types enabled. Only one should be active.', [], 422);
                }

                $updateData = [
                    'starting_date' => $data['starting_date'] ?? $employee->starting_date,
                    'ending_date' => $data['ending_date'] ?? $employee->ending_date,
                ];

                // Deal type: benefit amount
                if ($company->is_benefit_amount_deal == 1) {
                    $updateData['benefit_amount'] = $company->globel_amount;
                    $updateData['free_order_limit'] = 0;
                    $updateData['is_benefit_amount_deal'] = 1;
                    $updateData['is_free_order_deal'] = 0;

                    $employee->update($updateData);

                    $transaction = Transaction::create([
                        'employee_id' => $employee->id,
                        'amount' => $company->globel_amount,
                        'balance' => $company->globel_amount,
                        'transaction_type' => 'credit',
                        'description' => '',
                    ]);
                }
                // Deal type: free order
                elseif ($company->is_free_order_deal == 1) {
                    $updateData['free_order_limit'] = $company->global_free_order_limit;
                    $updateData['benefit_amount'] = 0;
                    $updateData['is_benefit_amount_deal'] = 0;
                    $updateData['is_free_order_deal'] = 1;

                    $employee->update($updateData);

                    $transaction = null; // No monetary transaction
                } else {
                    // No active deal — skip
                    continue;
                }

                $transactions[] = [
                    'employee_id' => $employee->id,
                    'transaction_id' => $transaction->id ?? null,
                    'status' => 'success',
                ];
            }

            DB::commit();

            return $this->successResponse(['model' => 'employee'], 'Employee deals updated successfully', [
                'transactions' => $transactions,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'employee'], $e->getMessage(), [], 424);
        }
    }




    public function assignProduct(Request $request)
    {
        try {
            $request->validate([
                'employeeids' => 'required|array',
                'employeeids.*' => 'required|integer',

                'productid' => 'required|array',
                'productid.*' => 'required|integer',

            ]);

            DB::beginTransaction();


            $companyId = auth('sanctum')->user()->company_id;
            $employeeIds = $request->employeeids;
            $productIds = $request->productid;
            $newRecords = [];

            foreach ($employeeIds as $employeeId) {
                foreach ($productIds as $productId) {
                    $exists = EmployeeProduct::where([
                        'company_id' => $companyId,
                        'employee_id' => $employeeId,
                        'product_id' => $productId,
                    ])->exists();

                    if (!$exists) {
                        $newRecords[] = [
                            'company_id' => $companyId,
                            'employee_id' => $employeeId,
                            'product_id' => $productId,
                        ];
                    }
                }
            }
            if (!empty($newRecords)) {
                EmployeeProduct::insert($newRecords);
            }

            DB::commit();

            return $this->successResponse(array('model' => 'employee'), 'Product Assigned Successfully', []);
        } catch (\Exception $e) {

            DB::rollBack();
            return $this->errorResponse(['model' => 'employee'], $e->getMessage(), [], 422);
        }
    }


    public function employepassword(Request $request)
    {


        try {
            $request->validate([
                'employee_id'   => 'required',
                'old_password'  => 'required',
                'new_password'  => 'required',
            ]);
            $employe = User::where('employee_id', $request->employee_id)->first();
            if (!$employe) {
                return $this->errorResponse(['model' => 'employe'], 'employe not found', [], 404);
            }


            if (!Hash::check($request->old_password, $employe->password)) {
                return $this->errorResponse(['model' => 'employe'], 'Old password is incorrect', [], 400);
            }


            $employe->password = Hash::make($request->new_password);
            $employe->save();
            return $this->successResponse(['model' => 'employee'], 'Password updated successfully', ['User_id' => $employe->id]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'employe'], $e->getMessage(), [], 422);
        }
    }

    public function updatedetails(Request $request)
    {

        try {

            $request->validate([
                'employee_id' => 'required|exists:employees,id',
                'name' => 'nullable|string|max:255',
                'phone' => 'nullable|string|max:20',
            ]);


            DB::beginTransaction();

            $employee = Employee::findOrFail($request->employee_id);
            $user = User::where('employee_id', $request->employee_id)->where('role', 'employee')->firstOrFail();

            $employee->update([
                'phone' => $request->phone ?? $employee->phone,
            ]);
            $user->update([
                'name' => $request->name ?? $user->name,
            ]);
            DB::commit();

            return $this->successResponse(['model' => 'company'], 'Company and User updated successfully', [
                'company' => $employee,
            ]);


            // return response()->json(['message' => 'Employee details updated successfully'], 200);


        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'employe'], $e->getMessage(), [], 422);
        }
    }
}
