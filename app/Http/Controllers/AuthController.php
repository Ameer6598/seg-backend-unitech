<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Order;
use App\Models\Company;
use App\Models\Employee;
use App\Traits\ApiResponse;
use Illuminate\Support\Str;
use Illuminate\Http\Request;

use App\Mail\ForgotPasswordMail;
use App\Models\PrecriptionDetails;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Laravel\Sanctum\PersonalAccessToken;
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
        }

        $token = $user->createToken('auth_token')->plainTextToken;
        return $this->successResponse(array('model' => 'users'), 'User Login successfully', [
            'access_token' => $token,
            'token_type' => 'Bearer',
            'role' => $user->role,
            'benefit_amount' => $user->role === 'employee'
                ? Employee::where('id', $user->employee_id)->value('benefit_amount')
                : Company::where('id', $user->company_id)->value('benefit_amount'),

            'order_count' => Order::where('employee_id', $user->employee_id)->count(),
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
