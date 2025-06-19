<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Company;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class AdminController extends Controller
{
    use ApiResponse;

    public function updateOwnerDetails(Request $request)
    {

        try {
            $user = Auth::user();
            if (!$user instanceof User) {
                return $this->errorResponse(
                    ['model' => 'user'],
                    'User not authenticated',
                    [],
                    401
                );
            }

            $validatedData = $request->validate([
                'name'         => 'nullable|string|max:255',
                'email'        => 'nullable|email|unique:users,email,' . $user->id,
                'password'     => 'nullable|min:6',
                'old_password' => $request->password ? 'required|string' : 'nullable',
            ]);

            if ($request->password && !Hash::check($request->old_password, $user->password)) {
                return $this->errorResponse(
                    ['model' => 'user'],
                    'Old password is incorrect',
                    [],
                    422
                );
            }

            DB::beginTransaction();

            if ($request->has('name')) {
                $user->name = $request->name;
            }
            if ($request->has('email')) {
                $user->email = $request->email;
            }
            if ($request->password) {
                $user->password = Hash::make($request->password);
            }

            $user->save();

            DB::commit();

            return $this->successResponse(
                ['model' => 'user'],
                'User updated successfully',
                ['user' => $user]
            );

        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(
                ['model' => 'user'],
                $e->getMessage(),
                [],
                500
            );
        }
    }





}
