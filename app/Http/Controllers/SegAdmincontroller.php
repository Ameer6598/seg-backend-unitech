<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\SegSubadmin;
use App\Models\User;
use App\Traits\ApiResponse;

use App\Models\SubadminPermissions;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Carbon\Carbon;

class SegAdmincontroller extends Controller
{
    use ApiResponse;

    public function createsubadmin(Request $request)
    {
        try {

            $rules = [
                'name' => 'required|string|max:255',
                'email' => 'required|email|unique:seg_subadmin,email|unique:users,email',
                'phone' => 'required|string|max:20',
                'address' => 'required|string|max:255',
                'password' => 'required|string',
            ];

            // Add 0 or 1 validation for each permission field
            $permissionFields = [
                'frame_create',
                'frame_read',
                'frame_update',
                'frame_delete',
                'frame_assign',
                'category_create',
                'category_read',
                'category_update',
                'category_delete',
                'frame_size_create',
                'frame_size_read',
                'frame_size_update',
                'frame_size_delete',
                'rim_type_create',
                'rim_type_read',
                'rim_type_update',
                'rim_type_delete',
                'styles_create',
                'styles_read',
                'styles_update',
                'styles_delete',
                'material_create',
                'material_read',
                'material_update',
                'material_delete',
                'shapes_create',
                'shapes_read',
                'shapes_update',
                'shapes_delete',
                'manufacture_create',
                'manufacture_read',
                'manufacture_update',
                'manufacture_delete',
                'view_order_history',
                'update_order',
                'company_create',
                'company_read',
                'company_update',
                'company_impersinate',
                'employee_read',
                'employee_update',
                'employee_impersinate',
                'lens_material_create',
                'lens_material_read',
                'lens_material_update',
                'lens_material_delete',
                'lens_material_assign',
                'scratch_coating_create',
                'scratch_coating_read',
                'scratch_coating_update',
                'scratch_coating_delete',
                'scratch_coating_assign',
                'lens_tint_create',
                'lens_tint_read',
                'lens_tint_update',
                'lens_tint_delete',
                'lens_tint_assign',
                'lens_protection_create',
                'lens_protection_read',
                'lens_protection_update',
                'lens_protection_delete',
                'lens_protection_assign',
                'blue_light_protection_create',
                'blue_light_protection_read',
                'blue_light_protection_update',
                'blue_light_protection_delete',
                'blue_light_protection_assign',
                'lens_type_category_create',
                'lens_type_category_read',
                'lens_type_category_update',
                'lens_type_category_delete',
                'lens_type_sub_category_create',
                'lens_type_sub_category_read',
                'lens_type_sub_category_update',
                'lens_type_sub_category_delete',
                'lens_type_sub_category_assign',
            ];

            foreach ($permissionFields as $field) {
                $rules[$field] = 'required|in:0,1';
            }

            $request->validate($rules);

            DB::beginTransaction();

            // 2. Create subadmin in seg_subadmin table
            $segSubadmin = SegSubadmin::create([
                'name' => $request->name,
                'email' => $request->email,
                'phone' => $request->phone,
                'address' => $request->address,
            ]);

            // 3. Create user in users table
            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'verification_number' => Str::uuid(),
                'role' => 'seg_subadmin',
                'company_id' => null,
                'employee_id' => null,
                'seg_subadmin_id' => $segSubadmin->id,
            ]);

            // 4. Create permissions for this subadmin
            $permissions = $request->only([
                'frame_create',
                'frame_read',
                'frame_update',
                'frame_delete',
                'frame_assign',
                'category_create',
                'category_read',
                'category_update',
                'category_delete',
                'frame_size_create',
                'frame_size_read',
                'frame_size_update',
                'frame_size_delete',
                'rim_type_create',
                'rim_type_read',
                'rim_type_update',
                'rim_type_delete',
                'styles_create',
                'styles_read',
                'styles_update',
                'styles_delete',
                'material_create',
                'material_read',
                'material_update',
                'material_delete',
                'shapes_create',
                'shapes_read',
                'shapes_update',
                'shapes_delete',
                'manufacture_create',
                'manufacture_read',
                'manufacture_update',
                'manufacture_delete',
                'view_order_history',
                'update_order',
                'company_create',
                'company_read',
                'company_update',
                'company_impersinate',
                'employee_read',
                'employee_update',
                'employee_impersinate',
                'lens_material_create',
                'lens_material_read',
                'lens_material_update',
                'lens_material_delete',
                'lens_material_assign',
                'scratch_coating_create',
                'scratch_coating_read',
                'scratch_coating_update',
                'scratch_coating_delete',
                'scratch_coating_assign',
                'lens_tint_create',
                'lens_tint_read',
                'lens_tint_update',
                'lens_tint_delete',
                'lens_tint_assign',
                'lens_protection_create',
                'lens_protection_read',
                'lens_protection_update',
                'lens_protection_delete',
                'lens_protection_assign',
                'blue_light_protection_create',
                'blue_light_protection_read',
                'blue_light_protection_update',
                'blue_light_protection_delete',
                'blue_light_protection_assign',
                'lens_type_category_create',
                'lens_type_category_read',
                'lens_type_category_update',
                'lens_type_category_delete',
                'lens_type_sub_category_create',
                'lens_type_sub_category_read',
                'lens_type_sub_category_update',
                'lens_type_sub_category_delete',
                'lens_type_sub_category_assign',
            ]);

            // Add subadmin_id
            $permissions['subadmin_id'] = $segSubadmin->id;

            // 5. Create permissions
            SubadminPermissions::create($permissions);
            DB::commit();

            return $this->successResponse(
                ['model' => 'Subadmin'],
                'Subadmin created successfully',
                ['subadmin_id' => $segSubadmin->id]
            );
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'Subadmin'], $e->getMessage(), [], 422);
        }
    }


    public function updateSubadmin(Request $request, $id)
    {

        try {

          $user = User::where('role', 'seg_subadmin')->where('seg_subadmin_id', $id)->firstOrFail();

            $subadminId = $user->id;
            $userId = $user->seg_subadmin_id;
            

            $rules = [
                'name' => 'required|string|max:255',
                'email' => 'required|email|unique:seg_subadmin,email,' . $userId . '|unique:users,email,' . $subadminId,

                'phone' => 'required|string|max:20',
                'address' => 'required|string|max:255',
                'status' => 'required|in:0,1',
                'password' => 'nullable|string',
            ];

            // Add 0 or 1 validation for each permission field
            $permissionFields = [
                'frame_create',
                'frame_read',
                'frame_update',
                'frame_delete',
                'frame_assign' ,
                    'category_create',
                'category_read',
                'category_update',
                'category_delete',
                'frame_size_create',
                'frame_size_read',
                'frame_size_update',
                'frame_size_delete',
                'rim_type_create',
                'rim_type_read',
                'rim_type_update',
                'rim_type_delete',
                'styles_create',
                'styles_read',
                'styles_update',
                'styles_delete',
                'material_create',
                'material_read',
                'material_update',
                'material_delete',
                'shapes_create',
                'shapes_read',
                'shapes_update',
                'shapes_delete',
                'manufacture_create',
                'manufacture_read',
                'manufacture_update',
                'manufacture_delete',
                'view_order_history',
                'update_order',
                'company_create',
                'company_read',
                'company_update',
                'company_impersinate',
                'employee_read',
                'employee_update',
                'employee_impersinate',
                'lens_material_create',
                'lens_material_read',
                'lens_material_update',
                'lens_material_delete',
                'lens_material_assign',
                'scratch_coating_create',
                'scratch_coating_read',
                'scratch_coating_update',
                'scratch_coating_delete',
                'scratch_coating_assign',
                'lens_tint_create',
                'lens_tint_read',
                'lens_tint_update',
                'lens_tint_delete',
                'lens_tint_assign',
                'lens_protection_create',
                'lens_protection_read',
                'lens_protection_update',
                'lens_protection_delete',
                'lens_protection_assign',
                'blue_light_protection_create',
                'blue_light_protection_read',
                'blue_light_protection_update',
                'blue_light_protection_delete',
                'blue_light_protection_assign',
                'lens_type_category_create',
                'lens_type_category_read',
                'lens_type_category_update',
                'lens_type_category_delete',
                'lens_type_sub_category_create',
                'lens_type_sub_category_read',
                'lens_type_sub_category_update',
                'lens_type_sub_category_delete',
                'lens_type_sub_category_assign',
            ];

            foreach ($permissionFields as $field) {
                $rules[$field] = 'required|in:0,1';
            }

            $request->validate($rules);

            DB::beginTransaction();

            // Find the subadmin
            $segSubadmin = SegSubadmin::findOrFail($id);
            $user = User::where('seg_subadmin_id', $id)->firstOrFail();

            // Update seg_subadmin table
            $segSubadmin->update([
                'name' => $request->name,
                'email' => $request->email,
                'phone' => $request->phone,
                'address' => $request->address,
            ]);

            // Prepare user update data
            $userUpdateData = [
                'name' => $request->name,
                'email' => $request->email,
                'status' => $request->status,
            ];

            // Update password if provided
            if ($request->filled('password')) {
                $userUpdateData['password'] = Hash::make($request->password);
            }

            // Update users table
            $user->update($userUpdateData);

            // Update permissions
            $permissions = $request->only($permissionFields);
            $permissions['subadmin_id'] = $segSubadmin->id;

            // Assuming there's a permissions table, update it
            SubadminPermissions::updateOrCreate(
                ['subadmin_id' => $segSubadmin->id],
                $permissions
            );

            DB::commit();

            return $this->successResponse(
                ['model' => 'Subadmin'],
                'Subadmin updated successfully',
                ['subadmin_id' => $segSubadmin->id]
            );
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'Subadmin'], $e->getMessage(), [], 422);
        }
    }

    public function deleteSubadmin($id)
    {
        try {
            DB::beginTransaction();

            // Find the subadmin
            $segSubadmin = SegSubadmin::findOrFail($id);
            $user = User::where('seg_subadmin_id', $id)->firstOrFail();

            // Delete related permissions
            SubadminPermissions::where('subadmin_id', $id)->delete();

            // Delete from users table
            $user->delete();

            // Delete from seg_subadmin table
            $segSubadmin->delete();

            DB::commit();

            return $this->successResponse(
                ['model' => 'Subadmin'],
                'Subadmin deleted successfully',
                []
            );
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'Subadmin'], $e->getMessage(), [], 422);
        }
    }
    public function getSubadmin(Request $request)
    {
        try {
            // Fetch subadmins with related user and permissions
            $segSubadmins = SegSubadmin::with(['user', 'permissions'])->get();

            // Transform the data to match the desired format
            $transformedSubadmins = $segSubadmins->map(function ($subadmin) {
                // Transform user status (0/1 to false/true)
                $user = $subadmin->user->toArray();
                $user['status'] = (bool) $user['status'];

                // Transform permissions
                $permissions = $subadmin->permissions->toArray();
                $transformedPermissions = [
                    'id' => $permissions['id'],
                    'subadmin_id' => $permissions['subadmin_id'],
                    'product_management' => [
                        'frame' => [
                            'create' => (bool) $permissions['frame_create'],
                            'read' => (bool) $permissions['frame_read'],
                            'update' => (bool) $permissions['frame_update'],
                            'delete' => (bool) $permissions['frame_delete'],
                            'assign' => (bool) $permissions['frame_assign'],
                        ],
                        'category' => [
                            'create' => (bool) $permissions['category_create'],
                            'read' => (bool) $permissions['category_read'],
                            'update' => (bool) $permissions['category_update'],
                            'delete' => (bool) $permissions['category_delete'],
                        ],
                        'frame_size' => [
                            'create' => (bool) $permissions['frame_size_create'],
                            'read' => (bool) $permissions['frame_size_read'],
                            'update' => (bool) $permissions['frame_size_update'],
                            'delete' => (bool) $permissions['frame_size_delete'],
                        ],
                        'rim_type' => [
                            'create' => (bool) $permissions['rim_type_create'],
                            'read' => (bool) $permissions['rim_type_read'],
                            'update' => (bool) $permissions['rim_type_update'],
                            'delete' => (bool) $permissions['rim_type_delete'],
                        ],
                        'styles' => [
                            'create' => (bool) $permissions['styles_create'],
                            'read' => (bool) $permissions['styles_read'],
                            'update' => (bool) $permissions['styles_update'],
                            'delete' => (bool) $permissions['styles_delete'],
                        ],
                        'material' => [
                            'create' => (bool) $permissions['material_create'],
                            'read' => (bool) $permissions['material_read'],
                            'update' => (bool) $permissions['material_update'],
                            'delete' => (bool) $permissions['material_delete'],
                        ],
                        'shapes' => [
                            'create' => (bool) $permissions['shapes_create'],
                            'read' => (bool) $permissions['shapes_read'],
                            'update' => (bool) $permissions['shapes_update'],
                            'delete' => (bool) $permissions['shapes_delete'],
                        ],
                        'manufacture' => [
                            'create' => (bool) $permissions['manufacture_create'],
                            'read' => (bool) $permissions['manufacture_read'],
                            'update' => (bool) $permissions['manufacture_update'],
                            'delete' => (bool) $permissions['manufacture_delete'],
                        ],
                    ],
                    'lens_management' => [
                        'lens_material' => [
                            'create' => (bool) $permissions['lens_material_create'],
                            'read' => (bool) $permissions['lens_material_read'],
                            'update' => (bool) $permissions['lens_material_update'],
                            'delete' => (bool) $permissions['lens_material_delete'],
                            'assign' => (bool) $permissions['lens_material_assign'],
                        ],
                        'scratch_coating' => [
                            'create' => (bool) $permissions['scratch_coating_create'],
                            'read' => (bool) $permissions['scratch_coating_read'],
                            'update' => (bool) $permissions['scratch_coating_update'],
                            'delete' => (bool) $permissions['scratch_coating_delete'],
                            'assign' => (bool) $permissions['scratch_coating_assign'],
                        ],
                        'lens_tint' => [
                            'create' => (bool) $permissions['lens_tint_create'],
                            'read' => (bool) $permissions['lens_tint_read'],
                            'update' => (bool) $permissions['lens_tint_update'],
                            'delete' => (bool) $permissions['lens_tint_delete'],
                            'assign' => (bool) $permissions['lens_tint_assign'],
                        ],
                        'lens_protection' => [
                            'create' => (bool) $permissions['lens_protection_create'],
                            'read' => (bool) $permissions['lens_protection_read'],
                            'update' => (bool) $permissions['lens_protection_update'],
                            'delete' => (bool) $permissions['lens_protection_delete'],
                            'assign' => (bool) $permissions['lens_protection_assign'],
                        ],
                        'blue_light_protection' => [
                            'create' => (bool) $permissions['blue_light_protection_create'],
                            'read' => (bool) $permissions['blue_light_protection_read'],
                            'update' => (bool) $permissions['blue_light_protection_update'],
                            'delete' => (bool) $permissions['blue_light_protection_delete'],
                            'assign' => (bool) $permissions['blue_light_protection_assign'],
                        ],
                    ],
                    'lens_type_management' => [
                        'lens_type_category' => [
                            'create' => (bool) $permissions['lens_type_category_create'],
                            'read' => (bool) $permissions['lens_type_category_read'],
                            'update' => (bool) $permissions['lens_type_category_update'],
                            'delete' => (bool) $permissions['lens_type_category_delete'],
                        ],
                        'lens_type_sub_category' => [
                            'create' => (bool) $permissions['lens_type_sub_category_create'],
                            'read' => (bool) $permissions['lens_type_sub_category_read'],
                            'update' => (bool) $permissions['lens_type_sub_category_update'],
                            'delete' => (bool) $permissions['lens_type_sub_category_delete'],
                            'assign' => (bool) $permissions['lens_type_sub_category_assign'],
                        ],
                    ],
                    'order_management' => [
                        'view_order_history' => (bool) $permissions['view_order_history'],
                        'update_order' => (bool) $permissions['update_order'],
                    ],
                    'company_management' => [
                        'create' => (bool) $permissions['company_create'],
                        'read' => (bool) $permissions['company_read'],
                        'update' => (bool) $permissions['company_update'],
                        'impersonate' => (bool) $permissions['company_impersinate'],
                    ],
                    'employee_management' => [
                        'read' => (bool) $permissions['employee_read'],
                        'update' => (bool) $permissions['employee_update'],
                        'impersonate' => (bool) $permissions['employee_impersinate'],
                    ],
                    'created_at' => $permissions['created_at'],
                    'updated_at' => $permissions['updated_at'],
                ];

                // Combine transformed data
                return array_merge($subadmin->toArray(), [
                    'user' => $user,
                    'permissions' => $transformedPermissions,
                ]);
            });

            return $this->successResponse(
                ['model' => 'Subadmin'],
                'Subadmins retrieved successfully',
                ['subadmins' => $transformedSubadmins]
            );
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'Subadmin'], $e->getMessage(), [], 422);
        }
    }
}
