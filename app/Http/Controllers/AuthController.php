<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Order;
use App\Models\Company;
use App\Models\Employee;
use App\Models\SegSubadmin;
use App\Traits\ApiResponse;
use Illuminate\Support\Str;

use Illuminate\Http\Request;
use App\Mail\ForgotPasswordMail;
use App\Models\PrecriptionDetails;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Laravel\Sanctum\PersonalAccessToken;
use App\Models\CompanySubadminsPermissions;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    //
    use ApiResponse;


    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $user = User::where('email', $request->email)->first();
        if ($user->status == 0) {
            throw ValidationException::withMessages([
                'email' => ['Your account is currently inactive.'],
            ]);
        }
        if (! $user || ! Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }
        $logourl = env('LOGO_URL');
        $companyLogo = Company::where('id', $user->company_id)->value('company_logo');
        $logoUrl = $companyLogo ? $logourl . $companyLogo : null;
        $user->load(['Employedata', 'Companydata']); // Eager load relationships
        $filteredUserData = [];


        $pdMissing = false;
        $latestPrescription = null;

        if ($user->role === 'employee') {


            $latestPrescription = PrecriptionDetails::where('employee_id', $user->employee_id)->latest()->first();

            if (is_null($latestPrescription) || is_null($latestPrescription->pupil_distance_online)) {
                $pdMissing = true;
            }


            $filteredUserData = [
                'name' => $user->name,
                'email' => $user->email,
                'id' => $user->employee_id,
                'phone_no' => optional($user->Employedata)->phone,
                'benefits' => optional($user->Companydata)->benefits,
                'last_prescription' => $latestPrescription,

            ];
        } elseif ($user->role === 'company') {
            $filteredUserData = [
                'id' => $user->company_id,
                'username' => $user->name,
                'name' => optional($user->Companydata)->company_name,
                'email' => $user->email,
                'phone_no' => optional($user->Companydata)->phone,
                'address' => optional($user->Companydata)->address,
            ];
        } elseif ($user->role === 'company_subadmin') {
            $permission = CompanySubadminsPermissions::where('user_id', $user->id)->first();

            $filteredUserData = [
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
                'phone_no' => $permission->phone ?? null,
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
        } else if ($user->role === 'seg_subadmin') {
            $Segadmin = SegSubadmin::where('id', $user->seg_subadmin_id)->with('permissions')->first();

            $permissions = $Segadmin->permissions?->toArray() ?? [];
            $filteredPermissions = [];

            foreach ($permissions as $key => $value) {
                if (!in_array($key, ['id', 'subadmin_id', 'created_at', 'updated_at'])) {
                    $filteredPermissions[$key] = (bool) $value;
                }
            }




            $filteredUserData = [
                'id' => $Segadmin->id,
                'username' => $Segadmin->name,
                'email' => $Segadmin->email,
                'phone' => $Segadmin->phone,
                'address' => $Segadmin->address,
                'permissions' => $filteredPermissions,

            ];
        }

        $token = $user->createToken('auth_token')->plainTextToken;
        $orderCount = 0;
        if ($user->role === 'employee') {
            $orderCount = Order::where('employee_id', $user->employee_id)->count();
        } elseif ($user->role === 'company') {
            $orderCount = 0;
        } elseif ($user->role === 'company_subadmin') {
            $orderCount = 0;
        }
        return $this->successResponse(array('model' => 'users'), 'User Login successfully', [
            'access_token' => $token,
            'token_type' => 'Bearer',
            'role' => $user->role,
            'benefit_amount' => $user->role === 'employee'
                ? Employee::where('id', $user->employee_id)->value('benefit_amount')
                : Company::where('id', $user->company_id)->value('benefit_amount'),
            'order_count' => $orderCount,
            'logourl' => $logoUrl,
            'UserData' => $filteredUserData,
            'is_pd_missing' => $pdMissing,
            'pd_message' => $pdMissing ? 'Your PD measurement is not saved in the existing prescription. Please save it here.' : null,
        ]);
    }


    public function set(Request $request)
    {
        try {
            DB::beginTransaction();

            $request->validate([
                'id' => 'required|integer',
                'verification_number' => 'required|string',
                'password' => 'required|string',
            ]);

            $user = User::find($request->id);

            if (!$user) {
                return $this->errorResponse(['model' => 'user'], 'User not found', [], 404);
            }

            // Check if verification number matches
            if ($user->verification_number !== $request->verification_number) {
                return $this->errorResponse(['model' => 'user'], 'Verification number is Invalid.', [], 422);
            }

            // Optional: Check if time limit exceeded (within 12 hours)
            if ($user->created_at && now()->diffInHours($user->created_at) > 12) {
                return $this->errorResponse(['model' => 'user'], 'Time limit to reset password has expired.', [], 403);
            }

            // Update password
            $user->password = Hash::make($request->password);

            // Optional: clear verification number so link becomes useless after use
            $user->verification_number = '';

            $user->save();

            DB::commit();

            return $this->successResponse(['model' => 'user'], 'Password updated successfully.', [], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'user'], $e->getMessage(), [], 422);
        }
    }



    public function forgetpassword(Request $request)
    {
        try {
            DB::beginTransaction();

            $request->validate([
                'email' => 'required|email',
            ]);

            // Fix typo: $request->Emai -> $request->email
            $user = User::where('email', $request->email)->first();

            if (!$user) {
                return $this->errorResponse(['model' => 'user'], 'User not found', [], 404);
            }

            // Generate new verification number
            $user->verification_number = Str::uuid();
            $user->save();

            DB::commit();

            // Generate password reset link
            $resetLink = "https://app.safetyeyeguard.com/new-password/{$user->id}/{$user->verification_number}";

            // Send mail
            Mail::to($user->email)->send(new ForgotPasswordMail($user->name, $resetLink));

            return $this->successResponse(['model' => 'user'], 'Reset link sent successfully.', [], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'user'], $e->getMessage(), [], 422);
        }
    }

    public function logout(Request $request)
    {
        // Logout from current device only
        $request->user()->currentAccessToken()->delete();

        return $this->successResponse([], 'Successfully logged out from current device');
    }

    public function logoutAll(Request $request)
    {
        $request->user()->tokens()->delete();

        return $this->successResponse([], 'Successfully logged out from all devices');
    }


    public function validateToken(Request $request)
    {

        return $this->successResponse([], 'Token is valid');
    }


    public function loginerror(Request $request)
    {
        return response()->json([
            'message' => 'unauthorized',
        ], 401);
    }
}
