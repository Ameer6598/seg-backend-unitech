<?php

namespace App\Http\Controllers;
use App\Models\Company;
use App\Models\Employee;
use App\Models\User;
use App\Models\Order;
use Illuminate\Validation\ValidationException;
use App\Traits\ApiResponse;

use Illuminate\Http\Request;

class ImpersonationController extends Controller
{
    use ApiResponse;

    public function impersonatecompany(request $request,$id)
    {
        if ($request->user()->role !== 'owner') {
            return response()->json(['error' => 'Unauthorized'], 403);
        }
    
        $user = User::where('role', 'company')->where('company_id', $id)->first();
    
        if (! $user) {
            return response()->json(['error' => 'User not found'], 404);
        }
    
        if ($user->status == 0) {
            throw ValidationException::withMessages([
                'email' => ['This account is currently inactive.'],
            ]);
        }
    
        $token = $user->createToken('impersonation_token')->plainTextToken;
    



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


    public function leaveImpersonation(Request $request)
    {

        $token = $request->bearerToken();
    
        if (! $token) {
            return response()->json(['error' => 'No token provided'], 401);
        }
    
        // Find the token record in personal_access_tokens table
        $tokenModel = \Laravel\Sanctum\PersonalAccessToken::findToken($token);
    
        if (! $tokenModel || $tokenModel->tokenable->role !== 'owner') {
            return response()->json(['error' => 'Invalid or unauthorized token'], 403);
        }
    
        $superadmin = $tokenModel->tokenable;
    
        // Generate new token to resume session as superadmin
        $newToken = $superadmin->createToken('superadmin_return')->plainTextToken;
    
        return response()->json([
            'message' => 'Returned to superadmin account successfully',
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
    

}
