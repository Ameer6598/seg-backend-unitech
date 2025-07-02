<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Order;
use App\Models\Company;
use App\Models\Employee;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

use App\Models\PrecriptionDetails;
use Illuminate\Validation\ValidationException;

class ImpersonationController extends Controller
{
    use ApiResponse;

    public function impersonatecompany(Request $request, $id)
    {
        if ($request->user()->role !== 'owner') {
            return response()->json(['error' => 'Unauthorized'], 403);
        }

        $superadmin = $request->user();
        $originalToken = $request->bearerToken();

        $user = User::where('role', 'company')->where('company_id', $id)->first();

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        if ($user->status == 0) {
            throw ValidationException::withMessages([
                'email' => ['This account is currently inactive.'],
            ]);
        }


        $token = $user->createToken('impersonation_token', [
            'is_impersonation' => true,
            'impersonator_id' => $superadmin->id,
            'original_token' => $originalToken,
        ])->plainTextToken;

        $logourl = env('LOGO_URL');
        $companyLogo = Company::where('id', $user->company_id)->value('company_logo');
        $logoUrl = $companyLogo ? $logourl . $companyLogo : null;

        $user->load(['Employedata', 'Companydata']);

        $filteredUserData = [
            'id' => $user->company_id,
            'username' => $user->name,
            'name' => optional($user->Companydata)->company_name,
            'email' => $user->email,
            'phone_no' => optional($user->Companydata)->phone,
            'address' => optional($user->Companydata)->address,
        ];

        return $this->successResponse(array('model' => 'users'), 'Impersonated as Company successfully', [
            'access_token' => $token,
            'token_type' => 'Bearer',
            'role' => $user->role,
            'benefit_amount' => Employee::where('id', $user->employee_id)->value('benefit_amount'),
            'order_count' => Order::where('employee_id', $user->employee_id)->count(),
            'logourl' => $logoUrl,
            'UserData' => $filteredUserData,
        ]);
    }

    public function impersonateemployee(Request $request, $id)
    {
        if (!in_array($request->user()->role, ['owner', 'company'])) {
            return response()->json(['error' => 'Unauthorized'], 403);
        }

        $superadmin = $request->user();
        $originalToken = $request->bearerToken();

        $user = User::where('role', 'employee')->where('employee_id', $id)->first();

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        if ($user->status == 0) {
            throw ValidationException::withMessages([
                'email' => ['This account is currently inactive.'],
            ]);
        }


        $token = $user->createToken('impersonation_token', [
            'is_impersonation' => true,
            'impersonator_id' => $superadmin->id,
            'original_token' => $originalToken,
        ])->plainTextToken;

        $logourl = env('LOGO_URL');
        $companyLogo = Company::where('id', $user->company_id)->value('company_logo');
        $logoUrl = $companyLogo ? $logourl . $companyLogo : null;

        $user->load(['Employedata', 'Companydata']);

        $latestPrescription = PrecriptionDetails::where('employee_id', $user->employee_id)->latest()->first();

        $pdMissing = is_null($latestPrescription) || is_null($latestPrescription->pupil_distance_online);


        $filteredUserData = [
            'id' => $user->company_id,
            'username' => $user->name,
            'name' => optional($user->Companydata)->company_name,
            'email' => $user->email,
            'phone_no' => optional($user->Companydata)->phone,
            'benefits' => optional($user->Companydata)->benefits,
            'address' => optional($user->Companydata)->address,
            'last_prescription' => $latestPrescription,


        ];

        return $this->successResponse(array('model' => 'users'), 'Impersonated as Employe successfully', [
            'access_token' => $token,
            'token_type' => 'Bearer',
            'role' => $user->role,
            'benefit_amount' => Employee::where('id', $user->employee_id)->value('benefit_amount'),
            'order_count' => Order::where('employee_id', $user->employee_id)->count(),
            'logourl' => $logoUrl,
            'UserData' => $filteredUserData,
            'is_pd_missing' => $pdMissing,
            'pd_message' => $pdMissing ? 'Your PD measurement is not saved in the existing prescription. Please save it here.' : null,
        ]);
    }

    public function leaveImpersonation(Request $request)
    {
        $token = $request->bearerToken();

        if (!$token) {
            return response()->json(['error' => 'No token provided'], 401);
        }

        $tokenModel = \Laravel\Sanctum\PersonalAccessToken::findToken($token);

        if (!$tokenModel) {
            return response()->json(['error' => 'Invalid token'], 403);
        }

        // Check if this is an impersonation token
        if (empty($tokenModel->abilities['is_impersonation'])) {
            return response()->json(['error' => 'Not an impersonation token'], 400);
        }

        $impersonatorId = $tokenModel->abilities['impersonator_id'];
        $originalToken = $tokenModel->abilities['original_token'];

        // Revoke the impersonation token
        $tokenModel->delete();

        // Get the original superadmin user
        $superadmin = User::find($impersonatorId);
        if (!$superadmin) {
            return response()->json(['error' => 'Original user not found'], 404);
        }

        // Verify the original token is still valid
        $originalTokenModel = \Laravel\Sanctum\PersonalAccessToken::findToken($originalToken);
        if (!$originalTokenModel || $originalTokenModel->tokenable_id != $impersonatorId) {
            // If original token is invalid, create a new one
            $newToken = $superadmin->createToken('superadmin_return')->plainTextToken;
            return response()->json([
                'message' => 'Returned to superadmin account successfully (new token issued)',
                'access_token' => $newToken,
                'token_type' => 'Bearer',
                'role' => $superadmin->role,
                'user' => [
                    'id' => $superadmin->id,
                    'name' => $superadmin->name,
                    'email' => $superadmin->email,
                ]
            ]);
        }

        return response()->json([
            'message' => 'Returned to superadmin account successfully',
            'access_token' => $originalToken,
            'token_type' => 'Bearer',
            'role' => $superadmin->role,
            'user' => [
                'id' => $superadmin->id,
                'name' => $superadmin->name,
                'email' => $superadmin->email,
            ]
        ]);
    }
}
