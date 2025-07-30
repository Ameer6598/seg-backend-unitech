<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Company;
use App\Models\Employee;
use App\Models\Transaction;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Models\CompanyProduct;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;



// use DB;

class CompanyController extends Controller
{
    //
    use ApiResponse;



    public function create(Request $request)
    {
        try {
            $request->validate([
                'company_name' => 'required|string|max:255',
                'username' => 'required|string|max:255',
                'email' => 'required|email|unique:users,email',
                'phone' => 'required|unique:companies,phone',
                'password' => 'required|string|min:6',
                'company_logo' => 'nullable|image|max:5120',
                'company_Information' => 'nullable|string',
                'benefits' => 'nullable|string',
                'allow_pay_later' => 'required|in:0,1',

                'is_benefit_amount_deal' => 'required|in:0,1',
                'is_free_order_deal' => 'required|in:0,1',
                // Conditional validations
                'benefit_amount' => 'required_if:is_benefit_amount_deal,1|nullable|numeric|min:0',
                'starting_date' => 'required|date',
                'ending_date' => 'required|date|after_or_equal:starting_date',

                'free_order_limit' => 'required_if:is_free_order_deal,1|nullable|integer|min:1',
            ]);



            // Prevent both deal types from being active at the same time
            if ($request->is_benefit_amount_deal && $request->is_free_order_deal) {
                return $this->errorResponse(['model' => 'company'], 'You cannot enable both benefit and free order deal at the same time.', [], 422);
            }

            DB::beginTransaction();

            // Handle company logo upload
            $logoPath = null;
            if ($request->hasFile('company_logo')) {
                $file = $request->file('company_logo');
                $originalName = $file->getClientOriginalName();
                $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
                $destinationPath = public_path('projectimages/company_logos');
                if (!file_exists($destinationPath)) {
                    mkdir($destinationPath, 0777, true);
                }
                $file->move($destinationPath, $fileName);
                $logoPath = '/projectimages/company_logos/' . $fileName;
            }

            // Set initial values
            $benefitAmount = $request->benefit_amount ?? 0;
            $benefitType = 'credit';
            $startingDate = $request->starting_date ?? null;
            $endingDate = $request->ending_date ?? null;
            $freeOrderLimit = $request->free_order_limit ?? 0;


            $company = Company::create([
                'company_name' => $request->company_name,
                'address' => $request->address ?? '',
                'phone' => $request->phone ?? '',
                'company_logo' => $logoPath,
                'company_Information' => $request->company_Information,
                'benefits' => $request->benefits,
                'benefit_amount' => $benefitAmount,
                'globel_amount' => $benefitAmount,
                'starting_date' => $startingDate, // Assign starting_date
                'ending_date' => $endingDate, // Assign ending_date
                'is_benefit_amount_deal' => $request->is_benefit_amount_deal,
                'allow_pay_later' => $request->allow_pay_later,
                'is_free_order_deal' => $request->is_free_order_deal,
                'free_order_limit' => $freeOrderLimit,
                'global_free_order_limit' => $freeOrderLimit,

            ]);

            // Create the user
            $user = User::create([
                'name' => $request->username,
                'email' => $request->email,
                'role' => 'company',
                'company_id' => $company->id,
                'verification_number' => Str::uuid(),
                'password' => Hash::make($request->password),
            ]);


            if ($request->is_benefit_amount_deal && $benefitAmount > 0) {
                $transaction = Transaction::create([
                    'company_id' => $company->id,
                    'amount' => $benefitAmount,
                    'balance' => $company->benefit_amount,
                    'transaction_type' => $benefitType,
                ]);
            }

            DB::commit();

            return $this->successResponse(
                ['model' => 'company'],
                'Company and User created successfully',
                [
                    'company' => $company,
                    'transaction_id' => null,
                ]
            );
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'company'], $e->getMessage(), [], 422);
        }
    }

    public function update(Request $request)
    {
        try {
            $rules = [
                'company_name' => 'required|string|max:255',
                'username' => 'required',
                'email' => 'required|email',
                'company_id' => 'required',
                'status' => 'required|in:0,1',
                'company_logo' => 'nullable|image|max:5120',
                'company_Information' => 'nullable|string',
                'benefits' => 'nullable|string',
                'allow_pay_later' => 'required|in:0,1',


                'is_benefit_amount_deal' => 'required|in:0,1',
                'is_free_order_deal' => 'required|in:0,1',
                'starting_date' => 'required|date',
                'ending_date' => 'required|date|after_or_equal:starting_date',
                'assig_to_exsiting_employee' => 'required|boolean',
            ];

            if ($request->is_benefit_amount_deal && $request->is_free_order_deal) {
                return $this->errorResponse(['model' => 'company'], 'You cannot enable both benefit and free order deal at the same time.', [], 422);
            }

            // Add dynamic rules
            if ($request->is_benefit_amount_deal == 1) {
                $rules['benefit_amount'] = 'required|numeric|min:0';
            }

            if ($request->is_free_order_deal == 1) {
                $rules['free_order_limit'] = 'required|integer|min:1';
            }

            $validated = $request->validate($rules);

            DB::beginTransaction();

            $company = Company::findOrFail($request->company_id);
            $user = User::where('company_id', $request->company_id)->where('role', 'company')->firstOrFail();

            // ✅ Store original deal values before update
            $original_is_benefit_amount_deal = $company->is_benefit_amount_deal;
            $original_is_free_order_deal = $company->is_free_order_deal;

            $logoPath = $company->company_logo;

            if ($request->hasFile('company_logo')) {
                $oldLogoPath = public_path($company->company_logo);
                if ($company->company_logo && file_exists($oldLogoPath)) {
                    unlink($oldLogoPath);
                }

                $file = $request->file('company_logo');
                $originalName = $file->getClientOriginalName();
                $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
                $destinationPath = public_path('projectimages/company_logos');

                if (!file_exists($destinationPath)) {
                    mkdir($destinationPath, 0777, true);
                }

                $file->move($destinationPath, $fileName);
                $logoPath = '/projectimages/company_logos/' . $fileName;
            }

            // Prepare update data
            $updateData = [
                'company_name' => $request->company_name,
                'address' => $request->address ?? $company->address,
                'phone' => $request->phone ?? $company->phone,
                'company_logo' => $logoPath,
                'company_Information' => $request->company_Information,
                'benefits' => $request->benefits,
                'is_benefit_amount_deal' => $request->is_benefit_amount_deal,
                'allow_pay_later' => $request->allow_pay_later,
                

                'is_free_order_deal' => $request->is_free_order_deal,
                'starting_date' => $request->starting_date,
                'ending_date' => $request->ending_date,
            ];

            if ($request->is_benefit_amount_deal == 1) {
                $updateData['benefit_amount'] = $request->benefit_amount;
                $updateData['globel_amount'] = $request->benefit_amount;
                $updateData['free_order_limit'] = 0;
                $updateData['global_free_order_limit'] = 0;
            } elseif ($request->is_free_order_deal == 1) {
                $updateData['free_order_limit'] = $request->free_order_limit;
                $updateData['global_free_order_limit'] = $request->free_order_limit;
                $updateData['benefit_amount'] = 0;
                $updateData['globel_amount'] = 0;
            }

            $company->update($updateData);
            $user->update([
                'name' => $request->username,
                'email' => $request->email,
                'password' => $request->password ? Hash::make($request->password) : $user->password,
                'status' => $request->status,
            ]);

            // ✅ Check if deal type changed (inverted)
            $benefitInverted = $original_is_benefit_amount_deal != $request->is_benefit_amount_deal;
            $freeOrderInverted = $original_is_free_order_deal != $request->is_free_order_deal;

            if ($benefitInverted || $freeOrderInverted) {
                $employees = Employee::where('company_id', $company->id)->get();
                $assign = $request->has('assig_to_exsiting_employee') && $request->assig_to_exsiting_employee;

                foreach ($employees as $employee) {
                    if ($request->is_benefit_amount_deal == 1) {
                        $employee->is_benefit_amount_deal = 1;
                        $employee->is_free_order_deal = 0;
                        $employee->benefit_amount = $assign ? $company->globel_amount : 0;
                        $employee->free_order_limit = 0;
                    } elseif ($request->is_free_order_deal == 1) {
                        $employee->is_benefit_amount_deal = 0;
                        $employee->is_free_order_deal = 1;
                        $employee->free_order_limit = $assign ? $company->global_free_order_limit : 0;
                        $employee->benefit_amount = 0;
                    }

                    $employee->starting_date = $request->starting_date;
                    $employee->ending_date = $request->ending_date;

                    $employee->save();
                }
            }

            // ✅ Create transaction if benefit_amount increased
            if (
                $request->is_benefit_amount_deal == 1 &&
                $request->benefit_amount > 0 &&
                $request->benefit_amount != $company->benefit_amount
            ) {
                Transaction::create([
                    'company_id' => $company->id,
                    'amount' => $request->benefit_amount,
                    'balance' => $request->benefit_amount,
                    'transaction_type' => 'credit',
                ]);
            }

            DB::commit();

            return $this->successResponse(['model' => 'company'], 'Company and User updated successfully', [
                'company' => $company,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'company'], $e->getMessage(), [], 422);
        }
    }


    public function delete($companyId)
    {
        try {
            DB::beginTransaction();
            // $company = Company::findOrFail($companyId);
            $users = User::where('company_id', $companyId)->get();

            foreach ($users as $user) {
                $user->status = $user->status == 0 ? 1 : 0;
                $user->save();
            }
            DB::commit();

            return $this->successResponse(['model' => 'company'], 'Company and User deleted successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'company'], $e->getMessage(), [], 422);
        }
    }

    public function getCompany($companyId)
    {
        try {

            $company = DB::table('companies')
                ->join('users', 'companies.id', '=', 'users.company_id')
                ->where('companies.id', $companyId)
                ->select('companies.*', 'users.name as username', 'users.email')
                ->first();

            if (!$company) {
                return $this->errorResponse(['model' => 'company'], 'Company not found', [], 404);
            }

            return $this->successResponse(['model' => 'company'], 'Company retrieved successfully', [
                'company' => $company,
            ]);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'company'], $e->getMessage(), [], 422);
        }
    }


    public function getAll()
    {
        try {
            $companies = Company::with([
                'users' => function ($query) {
                    $query->select('id', 'company_id', 'name as username', 'email', 'status');
                },
                'products',
                'lensmaterial',
                'scratchcoatings',
                'lenstint',
                'lensprotection',
                'bluelightprotection',
                'lenstypesubcategories'
            ])->get();

            if ($companies->isEmpty()) {
                return $this->errorResponse(['model' => 'company'], 'No companies found', [], 404);
            }

            $formattedCompanies = $companies->map(function ($company) {
                return [
                    'id' => $company->id,
                    'company_name' => $company->company_name,
                    'address' => $company->address,
                    'phone' => $company->phone,
                    'company_logo' => $company->company_logo,
                    'company_Information' => $company->company_Information,
                    'benefits' => $company->benefits,
                    'is_benefit_amount_deal' => $company->is_benefit_amount_deal,
                    'is_free_order_deal' => $company->is_free_order_deal,
                    'benefit_amount' => $company->benefit_amount,
                    'free_order_limit' => $company->free_order_limit,
                    'starting_date' => $company->starting_date,
                    'ending_date' => $company->ending_date,
                    'created_at' => $company->created_at->format('Y-m-d H:i:s'),
                    'updated_at' => $company->updated_at->format('Y-m-d H:i:s'),
                    'username' => $company->users->first()->username ?? null,
                    'email' => $company->users->first()->email ?? null,
                    'status' => $company->users->first()->status ?? null,

                    'lensmaterial' => $company->lensmaterial->map(function ($material) {
                        return [
                            'material_id' => $material->id,
                            'material_title' => $material->title,
                        ];
                    }),
                    'scratchcoatings' => $company->scratchcoatings->map(function ($coating) {
                        return [
                            'coating_id' => $coating->id,
                            'coating_title' => $coating->title,
                        ];
                    }),
                    'lenstints' => $company->lenstint->map(function ($lenstint) {
                        return [
                            'lenstint_id' => $lenstint->id,
                            'lenstint_title' => $lenstint->title,
                        ];
                    }),
                    'lensprotection' => $company->lensprotection->map(function ($lensprotection) {
                        return [
                            'lensprotection_id' => $lensprotection->id,
                            'lensprotection_title' => $lensprotection->title,
                        ];
                    }),
                    'bluelightprotection' => $company->bluelightprotection->map(function ($bluelightprotection) {
                        return [
                            'bluelightprotection_id' => $bluelightprotection->id,
                            'bluelightprotection_title' => $bluelightprotection->title,
                        ];
                    }),
                    'lenstypesubcategories' => $company->lenstypesubcategories->map(function ($lenstypesubcategories) {
                        return [
                            'lenstypesubcategories_id' => $lenstypesubcategories->id,
                            'lenstypesubcategories_title' => $lenstypesubcategories->title,
                        ];
                    }),

                    'products' => $company->products->map(function ($product) {
                        return [
                            'product_id' => $product->product_id,
                            'product_name' => $product->product_name,
                        ];
                    }),
                ];
            });

            return $this->successResponse(['model' => 'company'], 'Companies retrieved successfully', [
                'companies' => $formattedCompanies,
            ]);

            // return response()->json([
            //     'status' => 'Success',
            //     'meta' => ['model' => 'company'],
            //     'message' => 'Companies retrieved successfully',
            //     'data' => ['companies' => $formattedCompanies],
            //     'code' => 200,
            // ], 200);



        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'company'], $e->getMessage(), [], 422);
        }
    }

    public function getMyCompanyDetails()
    {
        try {

            $user = auth('sanctum')->user();

            if (!$user) {
                return $this->errorResponse(['model' => 'user'], 'Unauthorized access', [], 401);
            }

            $company = Company::with([
                'users' => function ($query) {
                    $query->select('id', 'company_id', 'name as username', 'email', 'status');
                },

                'lensmaterial',
                'scratchcoatings',
                'lenstint',
                'lensprotection',
                'bluelightprotection',
                'lenstypesubcategories'
            ])->find($user->company_id);

            if (!$company) {
                return $this->errorResponse(['model' => 'company'], 'Company not found', [], 404);
            }

            $formattedCompany = [
                'id' => $company->id,
                'company_name' => $company->company_name,
                'address' => $company->address,
                'phone' => $company->phone,
                'company_logo' => $company->company_logo,
                'company_Information' => $company->company_Information,
                'benefits' => $company->benefits,
                'created_at' => $company->created_at->format('Y-m-d H:i:s'),
                'updated_at' => $company->updated_at->format('Y-m-d H:i:s'),
                'username' => $company->users->first()->username ?? null,
                'email' => $company->users->first()->email ?? null,
                'status' => $company->users->first()->status ?? null,

                'lensmaterial' => $company->lensmaterial->map(function ($material) {
                    return [
                        'material_id' => $material->id,
                        'material_title' => $material->title,
                    ];
                }),
                'scratchcoatings' => $company->scratchcoatings->map(function ($coating) {
                    return [
                        'coating_id' => $coating->id,
                        'coating_title' => $coating->title,
                    ];
                }),
                'lenstints' => $company->lenstint->map(function ($lenstint) {
                    return [
                        'lenstint_id' => $lenstint->id,
                        'lenstint_title' => $lenstint->title,
                    ];
                }),
                'lensprotection' => $company->lensprotection->map(function ($lensprotection) {
                    return [
                        'lensprotection_id' => $lensprotection->id,
                        'lensprotection_title' => $lensprotection->title,
                    ];
                }),
                'bluelightprotection' => $company->bluelightprotection->map(function ($bluelightprotection) {
                    return [
                        'bluelightprotection_id' => $bluelightprotection->id,
                        'bluelightprotection_title' => $bluelightprotection->title,
                    ];
                }),
                'lenstypesubcategories' => $company->lenstypesubcategories->map(function ($lenstypesubcategories) {
                    return [
                        'lenstypesubcategories_id' => $lenstypesubcategories->id,
                        'lenstypesubcategories_title' => $lenstypesubcategories->title,
                    ];
                }),


            ];

            return $this->successResponse(['model' => 'company'], 'Company retrieved successfully', [
                'company' => $formattedCompany,
            ]);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'company'], $e->getMessage(), [], 422);
        }
    }


    public function companyPassword(Request $request)
    {

        try {

            $request->validate([
                'company_id'   => 'required',
                'old_password' => 'required',
                'new_password' => 'required',
            ]);
            $company = User::where('company_id', $request->company_id)->first();
            if (!$company) {
                return $this->errorResponse(['model' => 'company'], 'Company not found', [], 404);
            }
            if (!Hash::check($request->old_password, $company->password)) {
                return $this->errorResponse(['model' => 'company'], 'Old password is incorrect', [], 400);
            }
            $company->password = Hash::make($request->new_password);
            $company->save();

            return $this->successResponse(['model' => 'company'], 'Password updated successfully', ['User_id' => $company->id]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'company'], $e->getMessage(), [], 422);
        }
    }
    public function updatedetails(Request $request)
    {

        try {

            $request->validate([
                'name' => 'nullable',
                'phone' => 'nullable',
                'company_logo' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'company_id' => 'required|exists:companies,id',
            ]);



            DB::beginTransaction();

            $company = Company::findOrFail($request->company_id);
            $user = User::where('company_id', $request->company_id)->where('role', 'company')->firstOrFail();

            $logoPath = $company->company_logo;

            if ($request->hasFile('company_logo')) {
                $oldLogoPath = public_path($company->company_logo);

                if ($company->company_logo && file_exists($oldLogoPath)) {
                    unlink($oldLogoPath);
                }


                $file = $request->file('company_logo');
                $originalName = $file->getClientOriginalName();
                $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
                $destinationPath = public_path('projectimages/company_logos');

                if (!file_exists($destinationPath)) {
                    mkdir($destinationPath, 0777, true);
                }

                $file->move($destinationPath, $fileName);
                $logoPath = 'projectimages/company_logos/' . $fileName;
            }

            $company->update([
                'company_logo' => $logoPath,
                'phone' => $request->phone ?? $company->phone,
            ]);


            $user->update([
                'name' => $request->name ?? $user->name,
            ]);

            DB::commit();

            return $this->successResponse(['model' => 'company'], 'Company and User updated successfully', [
                'company' => $company,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'employe'], $e->getMessage(), [], 422);
        }
    }

    public function assignProductToCompany(Request $request)
    {
        try {
            $request->validate([
                'company_ids' => 'required|array',
                'company_ids.*' => 'required|integer',
                'productid' => 'required|array',
                'productid.*' => 'required|integer',
            ]);

            DB::beginTransaction();

            $companyIds = $request->company_ids;
            $productIds = $request->productid;
            $newMappings = [];

            foreach ($companyIds as $companyId) {
                foreach ($productIds as $productId) {
                    $exists = CompanyProduct::where([
                        'company_id' => $companyId,
                        'product_id' => $productId,
                    ])->exists();

                    if (!$exists) {
                        $newMappings[] = [
                            'company_id' => $companyId,
                            'product_id' => $productId,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ];
                    }
                }
            }

            if (!empty($newMappings)) {
                CompanyProduct::insert($newMappings);
            }

            DB::commit();
            return $this->successResponse(['model' => 'company_product'], 'Products assigned to companies successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'company_product'], $e->getMessage(), [], 422);
        }
    }

    public function unassignProductFromCompany(Request $request)
    {
        try {
            $request->validate([
                'company_ids' => 'required|array',
                'company_ids.*' => 'required|integer',
                'productid' => 'required|array',
                'productid.*' => 'required|integer',
            ]);

            DB::beginTransaction();

            $companyIds = $request->company_ids;
            $productIds = $request->productid;

            foreach ($companyIds as $companyId) {
                foreach ($productIds as $productId) {
                    CompanyProduct::where('company_id', $companyId)
                        ->where('product_id', $productId)
                        ->delete();
                }
            }

            DB::commit();
            return $this->successResponse(['model' => 'company_product'], 'Products unassigned from companies successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'company_product'], $e->getMessage(), [], 422);
        }
    }
}
