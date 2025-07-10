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
                'benefits_amount_assign' => 'required|in:0,1',
                'frame_read' => 'required|in:0,1',
                'frame_assign' => 'required|in:0,1',
                'assigned_lenses_read' => 'required|in:0,1',
                'orders_list_read' => 'required|in:0,1',
                'new_order_create' => 'required|in:0,1',
                'employee_create' => 'required|in:0,1',
                'employee_read' => 'required|in:0,1',
                'employee_update' => 'required|in:0,1',
                'employee_delete' => 'required|in:0,1',
                'assign_product_to_employee' => 'required|in:0,1',
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
                'benefits_amount_assign' => $request->benefits_amount_assign,
                'frame_read' => $request->frame_read,
                'frame_assign' => $request->frame_assign,
                'assigned_lenses_read' => $request->assigned_lenses_read,
                'orders_list_read' => $request->orders_list_read,
                'new_order_create' => $request->new_order_create,
                'employee_create' => $request->employee_create,
                'employee_read' => $request->employee_read,
                'employee_update' => $request->employee_update,
                'employee_delete' => $request->employee_delete,
                'assign_product_to_employee' => $request->assign_product_to_employee,
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



    public function updateSubadmin(Request $request)
    {
        try {

            $User = auth('sanctum')->user();

            $request->validate([
                'name' => 'required|string|max:255',
                'email' => 'required|email|unique:users,email,' . $User->id,
                'password' => 'nullable|string|min:6',
                'address' => 'required|string',
                'phone' => 'required',
                'status' => 'required|in:0,1', // ✅ Added validation for status


                'benefits_amount_assign' => 'required|in:0,1',
                'frame_read' => 'required|in:0,1',
                'frame_assign' => 'required|in:0,1',
                'assigned_lenses_read' => 'required|in:0,1',
                'orders_list_read' => 'required|in:0,1',
                'new_order_create' => 'required|in:0,1',
                'employee_create' => 'required|in:0,1',
                'employee_read' => 'required|in:0,1',
                'employee_update' => 'required|in:0,1',
                'employee_delete' => 'required|in:0,1',
                'assign_product_to_employee' => 'required|in:0,1',
            ]);

            $companyId = auth('sanctum')->user()->company_id;

            DB::beginTransaction();

            // Update the subadmin user
            $user = User::where('id', $User->id)
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
            $permissions = CompanySubadminsPermissions::where('user_id', $user->id)->firstOrFail();
            $permissions->update([
                'address' => $request->address,
                'phone' => $request->phone,
                'benefits_amount_assign' => $request->benefits_amount_assign,
                'frame_read' => $request->frame_read,
                'frame_assign' => $request->frame_assign,
                'assigned_lenses_read' => $request->assigned_lenses_read,
                'orders_list_read' => $request->orders_list_read,
                'new_order_create' => $request->new_order_create,
                'employee_create' => $request->employee_create,
                'employee_read' => $request->employee_read,
                'employee_update' => $request->employee_update,
                'employee_delete' => $request->employee_delete,
                'assign_product_to_employee' => $request->assign_product_to_employee,
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


    public function deleteSubadmin(Request $request)
    {
        try {
            $User = auth('sanctum')->user();
            $companyId = $User->company_id;

            DB::beginTransaction();


            $user = User::where('id', $User->id)
                ->where('company_id', $companyId)
                ->where('role', 'company_subadmin')
                ->firstOrFail();

            CompanySubadminsPermissions::where('user_id', $user->id)->delete();

            $user->delete();

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
}
