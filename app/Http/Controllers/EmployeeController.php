<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Company;
use App\Models\Employee;

use App\Models\Transaction;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use App\Models\EmployeeProduct;
use App\Exports\ExportEmployees;
use App\Imports\ImportEmployees;
use Illuminate\Support\Facades\DB;
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
            'phone' => 'required|unique:employees,phone', // Checks uniqueness in employees table
            'password' => 'required',
            'designation' => 'required',
            'benefit_amount' => ['nullable', 'numeric'],
        ]);

        // Manual check for phone number in companies table
        if (\App\Models\Company::where('phone', $request->phone)->exists()) {
            throw new \Exception('The phone number is already in use by a company.');
        }

        $apiKey = env('MIAL_BOX'); // Ensure this is correctly set in .env
        if (!$apiKey) {
            throw new \Exception('MailboxLayer API key is missing.');
        }
        $response = Http::get("https://apilayer.net/api/check", [
            'access_key' => $apiKey,
            'email' => $request->email,
        ]);

        if ($response->failed()) {
            throw new \Exception('Email validation service is unavailable.');
        }

        $emailData = $response->json();

        if (!isset($emailData['mx_found']) || !$emailData['mx_found'] || !isset($emailData['smtp_check']) || !$emailData['smtp_check']) {
            throw new \Exception('Invalid or non-existent email address.');
        }

        DB::beginTransaction();
        $employee = Employee::create([
            'designation' => $request->designation ?? '',
            'status' => $request->status ?? '',
            'phone' => $request->phone ?? '',
            'benefit_amount' => $request->benefit_amount ?? 0,
            'company_id' => auth('sanctum')->user()->company_id,
        ]);

        User::create([
            'name' => $request->username,
            'email' => $request->email,
            'role' => 'employee',
            'company_id' => auth('sanctum')->user()->company_id,
            'employee_id' => $employee->id,
            'verification_number' => Str::uuid(),
            'password' => Hash::make($request->password),
        ]);

        if ($request->benefit_amount) {
            Transaction::create([
                'employee_id' => $employee->id,
                'transaction_type' => 'credit',
                'amount' => $request->benefit_amount ?? '',
                'balance' => $request->benefit_amount ?? '',
                'description' => $request->description ?? '',
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

    // public function getAll(Request $request)
    // {
    //     try {

    //         $companyId = auth('sanctum')->user()->company_id;

    //         $page = $request->input('page', 1); 
    //         $perPage = $request->input('per_page', 10); 


    //         $query = DB::table('employees')
    //             ->join('users as u1', 'employees.id', '=', 'u1.employee_id')
    //             ->join('companies as u2', 'employees.company_id', '=', 'u2.id')
    //             ->select('employees.*', 'u1.name as employeename', 'u1.status', 'u1.email', 'u2.company_name as companyname')
    //             ->when($companyId, function ($query, $companyId) {
    //                 return $query->where('employees.company_id', $companyId);
    //             });

    //         $total = $query->count();

    //         $employees = $query
    //             ->forPage($page, $perPage)
    //             ->get();

    //         if ($employees->isEmpty()) {
    //             return $this->errorResponse(['model' => 'employee'], 'No employees found', [], 404);
    //         }

    //         return $this->successResponse(['model' => 'employee'], 'employees retrieved successfully', [
    //             'employees' => $employees,
    //             'pagination' => [
    //                 'total' => $total,
    //                 'current_page' => (int)$page,
    //                 'per_page' => (int)$perPage,
    //                 'last_page' => ceil($total / $perPage),
    //             ]
    //         ]);
    //     } catch (\Exception $e) {
    //         return $this->errorResponse(['model' => 'employee'], $e->getMessage(), [], 422);
    //     }
    // }






    public function downloadSample()
    {
        $fileName = 'employee_sample.xlsx';
        return Excel::download(new ExportEmployees, $fileName);
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xlsx,csv|max:2048',
        ]);

        try {
            Excel::import(new ImportEmployees, $request->file('file'));

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

    public function bulkUpdate(Request $request)
    {
        $data = $request->validate([
            'employee_id' => 'required|array',
            'employee_id.*' => 'exists:employees,id',
            'amount' => 'required|numeric',
            'type' => 'required|in:credit,debit',
        ]);
        try {
            DB::beginTransaction();

            $transactions = [];
            foreach ($data['employee_id'] as $item) {
                $employee = Employee::findOrFail($item);
                $amount = $data['amount'];
                $type = $data['type'];

                if ($type === 'credit') {
                    $employee->benefit_amount += $amount;
                } else {
                    $employee->benefit_amount -= $amount;
                }
                $employee->save();

                $transaction = Transaction::create([
                    'employee_id' => $employee->id,
                    'amount' => $amount,
                    'balance' => $employee->benefit_amount,
                    'transaction_type' => $type,
                ]);

                $transactions[] = [
                    'employee_id' => $employee->id,
                    'transaction_id' => $transaction->id,
                    'status' => 'success',
                ];
            }

            DB::commit();
            return $this->successResponse(['model' => 'employee'], 'Transactions processed successfully', [
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
