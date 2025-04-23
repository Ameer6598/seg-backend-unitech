<?php

namespace App\Http\Controllers;

use App\Models\Company;
use App\Models\Employee;
use App\Models\User;
use App\Models\Order;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use App\Traits\ApiResponse;

use Illuminate\Http\Request;

class AuthController extends Controller
{
    //
    use ApiResponse;

    // public function register(Request $request)
    // {
    //     $request->validate([
    //         'name' => 'required|string|max:255',
    //         'email' => 'required|string|email|max:255|unique:users',
    //         'password' => 'required|string|min:8',
    //         'role' => 'required|string|in:owner,company,employee', // Validate role
    //     ]);

    //     $user = User::create([
    //         'name' => $request->name,
    //         'email' => $request->email,
    //         'password' => Hash::make($request->password),
    //         'role' => $request->role,
    //     ]);

    //     $token = $user->createToken('auth_token')->plainTextToken;

    //     return response()->json([
    //         'access_token' => $token,
    //         'token_type' => 'Bearer',
    //     ]);
    // }

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

        if ($user->role === 'employee') {
            $filteredUserData = [
                'name' => $user->name,
                'email' => $user->email,
                'employee_id' => $user->employee_id,
                'phone_no' => optional($user->Employedata)->phone,
            ];
        } elseif ($user->role === 'company') {
            $filteredUserData = [
                'company_id' => $user->company_id,
                'username' => $user->name,
                'company_name' => optional($user->Companydata)->company_name,
                'email' => $user->email,
                'phone_no' => optional($user->Companydata)->phone,
                'address' => optional($user->Companydata)->address,
            ];
        }


        $token = $user->createToken('auth_token')->plainTextToken;
        return $this->successResponse(array('model' => 'users'), 'User Login successfully', [
            'access_token' => $token,
            'token_type' => 'Bearer',
            'role' => $user->role,
            'benefit_amount' => Employee::where('id', $user->employee_id)->value('benefit_amount'),
            'order_count' => Order::where('employee_id', $user->employee_id)->count(),
            'logourl' => $logoUrl,
            'UserData' => $filteredUserData,
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return $this->successResponse(array('model' => 'users'), 'User Logout successfully', []);
    }
}
