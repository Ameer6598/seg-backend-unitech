<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Company;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use App\Models\CompanyProduct;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str; // Top par add karein agar nahi kiya



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
                'phone' => 'required|unique:companies,phone', // Checks uniqueness in companies table
                'password' => 'required|string|min:6',
                'company_logo' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:5120', // Max 5MB
                'company_Information' => 'nullable|string',
                'benefits' => 'nullable|string',
            ]);



            DB::beginTransaction();

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

            $company = Company::create([
                'company_name' => $request->company_name,
                'address' => $request->address ?? '',
                'phone' => $request->phone ?? '',
                'company_logo' => $logoPath,
                'company_Information' => $request->company_Information,
                'benefits' => $request->benefits,
            ]);

            $user = User::create([
                'name' => $request->username,
                'email' => $request->email,
                'role' => 'company',
                'company_id' => $company->id,
                'verification_number' => Str::uuid(),
                'password' => Hash::make($request->password),
            ]);

            DB::commit();

            return $this->successResponse(
                ['model' => 'company'],
                'Company and User created successfully',
                ['company' => $company]
            );
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'company'], $e->getMessage(), [], 422);
        }
    }



    public function update(Request $request)
    {

        try {
            $request->validate([
                'company_name' => 'required|string|max:255',
                'username' => 'required',
                'email' => 'required|email',
                'company_id' => 'required',
                'status' => 'required|in:0,1', // Correct syntax for in rule
                'company_logo' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
                'company_Information' => 'nullable|string',
                'benefits' => 'nullable|string',


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
                $logoPath = '/projectimages/company_logos/' . $fileName;
            }


            $company->update([
                'company_name' => $request->company_name,
                'address' => $request->address ?? $company->address,
                'phone' => $request->phone ?? $company->phone,
                'company_logo' => $logoPath,
                'company_Information' => $request->company_Information,
                'benefits' => $request->benefits,
            ]);

            $user->update([
                'name' => $request->username,
                'email' => $request->email,
                'password' => $request->password ? Hash::make($request->password) : $user->password,
                'status' => $request->status,
            ]);

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
            return $this->errorResponse(['model' => 'employe'], $e->getMessage(), [], 422);
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
}
