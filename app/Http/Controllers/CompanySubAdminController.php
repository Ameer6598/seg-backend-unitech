<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Support\Str;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use App\Models\CompanySubadminsPermissions;
use App\Traits\ApiResponse;


class CompanySubAdminController extends Controller
{
    use ApiResponse;


    public function createsubadmin(Request $request)
    {
        try {

            $request->validate([
                'name' => 'required|string|max:255',
                'email' => 'required|email|unique:users,email',
                'password' => 'required|string|min:6',

                'address' => 'required|string',
                'phone' => 'required',
                'assign_benefits_to_employee' => 'required|in:0,1',
                'frame_read' => 'required|in:0,1',
                'frame_assign' => 'required|in:0,1',
                'assigned_lenses_read' => 'required|in:0,1',
                'orders_list_read' => 'required|in:0,1',
                'new_order_create' => 'required|in:0,1',
                'employee_create' => 'required|in:0,1',
                'employee_read' => 'required|in:0,1',
                'employee_update' => 'required|in:0,1',
                'employee_delete' => 'required|in:0,1',

            ]);

            $companyId = auth('sanctum')->user()->company_id;
            // Begin database transaction
            DB::beginTransaction();

            // $user = User

            $user = User::where('company_id', $companyId)->where('role', 'company')->first();

            $user->load('Companydata'); // Eager load relationships



            // Create subadmin user
            $user = new User();
            $user->name = $request->name;
            $user->email = $request->email;
            $user->role = 'company_subadmin';
            $user->company_id = $companyId;
            $user->verification_number = Str::uuid();
            $user->password = Hash::make($request->password);
            $user->employee_id = null;
            $user->save();

            // Insert permissions using request values
            CompanySubadminsPermissions::create([
                'user_id' => $user->id,
                'company_name' => $user->Companydata->company_name,
                'address' => $request->address,
                'phone' => $request->phone,
                'assign_benefits_to_employee' => $request->assign_benefits_to_employee,
                'frame_read' => $request->frame_read,
                'frame_assign' => $request->frame_assign,
                'assigned_lenses_read' => $request->assigned_lenses_read,
                'orders_list_read' => $request->orders_list_read,
                'new_order_create' => $request->new_order_create,
                'employee_create' => $request->employee_create,
                'employee_read' => $request->employee_read,
                'employee_update' => $request->employee_update,
                'employee_delete' => $request->employee_delete,

                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // Commit the transaction
            DB::commit();

            return $this->successResponse(
                ['model' => 'company subadmin'],
                'Subadmin created with permissions successfully',
                ['user_id' => $user->id],
                201
            );
        } catch (\Exception $e) {
            // Rollback the transaction
            DB::rollBack();

            return $this->errorResponse(
                null,
                'Failed to create subadmin',
                ['error' => $e->getMessage()],
                500
            );
        }
    }

    public function getSubadmins(Request $request)
    {
        $authUser = auth('sanctum')->user();

        if ($authUser->role !== 'company') {
            return $this->errorResponse(null, 'Unauthorized access', [], 403);
        }

        // Get all subadmins with their permissions
        $subadmins = User::with('Permission')
            ->where('company_id', $authUser->company_id)
            ->where('role', 'company_subadmin')
            ->get()
            ->map(function ($user) {
                $permission = $user->Permission;

                return [
                    'id' => $permission->id ?? null,
                    'name' => $user->name,
                    'email' => $user->email,
                    'status' => $user->status,
                    'role' => $user->role,
                    'company_id' => $user->company_id,
                    'employee_id' => $user->employee_id,
                    'created_at' => $user->created_at,
                    'updated_at' => $user->updated_at,
                    'company_name' => $permission->company_name ?? null,
                    'address' => $permission->address ?? null,
                    'phone' => $permission->phone ?? null,
                    'permissions' => [
                        'assign_benefits_to_employee' => (bool) ($permission->assign_benefits_to_employee ?? false),
                        'frame_read' => (bool) ($permission->frame_read ?? false),
                        'frame_assign' => (bool) ($permission->frame_assign ?? false),
                        'assigned_lenses_read' => (bool) ($permission->assigned_lenses_read ?? false),
                        'orders_list_read' => (bool) ($permission->orders_list_read ?? false),
                        'new_order_create' => (bool) ($permission->new_order_create ?? false),
                        'employee_create' => (bool) ($permission->employee_create ?? false),
                        'employee_read' => (bool) ($permission->employee_read ?? false),
                        'employee_update' => (bool) ($permission->employee_update ?? false),
                        'employee_delete' => (bool) ($permission->employee_delete ?? false),

                    ],
                ];
            });

        return $this->successResponse(
            ['model' => 'subadmins'],
            'Subadmins retrieved successfully',
            $subadmins
        );
    }


    public function updateSubadmin(Request $request)
    {
        try {



            $request->validate([

                'user_id' => 'required',
                'name' => 'required|string|max:255',
                'email' => 'required|email',
                'password' => 'nullable|string|min:6',
                'address' => 'required|string',
                'phone' => 'required',
                'status' => 'required|in:0,1', // ✅ Added validation for status


                'assign_benefits_to_employee' => 'required|in:0,1',
                'frame_read' => 'required|in:0,1',
                'frame_assign' => 'required|in:0,1',
                'assigned_lenses_read' => 'required|in:0,1',
                'orders_list_read' => 'required|in:0,1',
                'new_order_create' => 'required|in:0,1',
                'employee_create' => 'required|in:0,1',
                'employee_read' => 'required|in:0,1',
                'employee_update' => 'required|in:0,1',
                'employee_delete' => 'required|in:0,1',
            ]);

            $companyId = auth('sanctum')->user()->company_id;

            DB::beginTransaction();

            // Update the subadmin user


            $subadmin  = CompanySubadminsPermissions::find($request->user_id);

            $user = User::where('id', $subadmin->user_id,)
                ->where('company_id', $companyId)
                ->where('role', 'company_subadmin')
                ->firstOrFail();

            $user->name = $request->name;
            $user->email = $request->email;
            $user->status = $request->status; // ✅ Set the status (0 or 1)
            if ($request->filled('password')) {
                $user->password = Hash::make($request->password);
            }
            $user->save();

            // Update permissions
            $permissions = CompanySubadminsPermissions::find($request->user_id);
            $permissions->update([
                'address' => $request->address,
                'phone' => $request->phone,
                'assign_benefits_to_employee' => $request->assign_benefits_to_employee,
                'frame_read' => $request->frame_read,
                'frame_assign' => $request->frame_assign,
                'assigned_lenses_read' => $request->assigned_lenses_read,
                'orders_list_read' => $request->orders_list_read,
                'new_order_create' => $request->new_order_create,
                'employee_create' => $request->employee_create,
                'employee_read' => $request->employee_read,
                'employee_update' => $request->employee_update,
                'employee_delete' => $request->employee_delete,

                'updated_at' => now(),
            ]);

            DB::commit();

            return $this->successResponse(
                ['model' => 'company subadmin'],
                'Subadmin updated successfully',
                ['user_id' => $user->id],
                200
            );
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(
                null,
                'Failed to update subadmin',
                ['error' => $e->getMessage()],
                500
            );
        }
    }


    public function deleteSubadminById($id)
    {
        try {
            $companyId = auth('sanctum')->user()->company_id;

            DB::beginTransaction();


            $data =   CompanySubadminsPermissions::find($id);


            $user = User::where('id', $data->user_id)
                ->where('company_id', $companyId)
                ->where('role', 'company_subadmin')
                ->first();


            $user->delete();
            $data->delete();

            DB::commit();

            return $this->successResponse(
                ['model' => 'company subadmin'],
                'Subadmin deleted successfully',
                ['user_id' => $user->id],
                200
            );
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(
                null,
                'Failed to delete subadmin',
                ['error' => $e->getMessage()],
                500
            );
        }
    }
    public function changepassword(Request $request)
    {
        try {

            $request->validate([
                'old_password' => 'required',
                'new_password' => 'required',
            ]);

            $UserId = auth('sanctum')->user()->id;

            $company_subadmin = User::where('id', $UserId)->first();
            if (!$company_subadmin) {
                return $this->errorResponse(['model' => 'company_subadmin'], 'company_subadmin not found', [], 404);
            }
            if (!Hash::check($request->old_password, $company_subadmin->password)) {
                return $this->errorResponse(['model' => 'company_subadmin'], 'Old password is incorrect', [], 400);
            }
            $company_subadmin->password = Hash::make($request->new_password);
            $company_subadmin->save();

            return $this->successResponse(['model' => 'company_subadmin'], 'Password updated successfully', ['User_id' => $company_subadmin->id]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'company_subadmin'], $e->getMessage(), [], 422);
        }
    }
    public function updatedetails(Request $request)
    {
        try {
            $request->validate([
                'name' => 'nullable|string|max:255',
                'phone' => 'nullable|string|max:20',
            ]);

            $UserId = auth('sanctum')->user()->id;

            DB::beginTransaction();

            $user = User::findOrFail($UserId);
            $subadmin = CompanySubadminsPermissions::where('user_id', $UserId)->firstOrFail();

            // Update name only if provided
            if ($request->filled('name')) {
                $user->name = $request->name;
                $user->save();
            }

            // Update phone only if provided
            if ($request->filled('phone')) {
                $subadmin->phone = $request->phone;
                $subadmin->save();
            }

            DB::commit();

            // You may return updated user and subadmin data as response
            $data = [
                'user' => $user,
                'subadmin' => $subadmin,
            ];

            return $this->successResponse(['model' => 'company subadmin'], 'Company subadmin updated successfully', [
                'company' => $data,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'company subadmin'], $e->getMessage(), [], 422);
        }
    }
}
