<?php

namespace App\Imports;

use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use App\Traits\ApiResponse;
use App\Models\Employee;
use App\Models\User;
use App\Models\Transaction;
use App\Models\Company;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Validator;

class ImportEmployees implements ToCollection, WithHeadingRow
{
    use ApiResponse;

    private $errors = [];

    public function collection(Collection $rows)
    {

        // foreach ($rows as $index => $row) {
        //     try {

        //         $phone = $row['phone'] ?? '';

        //         $isNA = strtoupper(trim($phone)) === 'N/A' || !preg_match('/^\d+$/', $phone);

        //         $validationRules = [
        //             'username' => 'required',
        //             'email' => 'required|email|unique:users,email',
        //             'designation' => 'required',
        //         ];

        //         if (!$isNA) {
        //             $validationRules['phone'] = 'required';
        //         } else {
        //             $validationRules['phone'] = 'required';
        //         }

        //         $validator = Validator::make($row->toArray(), $validationRules);

        //         if ($validator->fails()) {
        //             foreach ($validator->errors()->all() as $error) {
        //                 if (str_contains($error, 'email')) {
        //                     $this->errors[] = "Row " . ($index + 2) . ": The email '" . $row['email'] . "' has already been taken.";
        //                 } elseif (str_contains($error, 'phone')) {
        //                     $this->errors[] = "Row " . ($index + 2) . ": The phone number '" . $row['phone'] . "' has already been taken.";
        //                 } else {
        //                     $this->errors[] = "Row " . ($index + 2) . ": " . $error;
        //                 }
        //             }
        //             continue;
        //         }




        //         if ($isNA) {
        //             $phone = 'N/A';
        //         }

        //         DB::beginTransaction();

        //         $employee = Employee::create([
        //             'designation' => $row['designation'] ?? '',
        //             'status' => 'Active',
        //             'phone' => $phone,
        //             'benefit_amount' => 0,
        //             'company_id' => auth('sanctum')->user()->company_id,
        //         ]);

        //         $randomPassword = Str::random(8);
        //         User::create([
        //             'name' => $row['username'],
        //             'email' => $row['email'],
        //             'role' => 'employee',
        //             'company_id' => auth('sanctum')->user()->company_id,
        //             'employee_id' => $employee->id,
        //             'verification_number' => Str::uuid(),
        //             'password' => Hash::make($randomPassword),
        //         ]);

        //         DB::commit();
        //     } catch (\Exception $e) {
        //         DB::rollBack();
        //         $this->errors[] = "Row " . ($index + 2) . ": " . $e->getMessage();
        //     }
        // }
        foreach ($rows as $index => $row) {
            try {
                $phone = $row['phone'] ?? '';
                $phone = trim($phone);

                // Accept only digits or +digits, else set to 'N/A'
                if (preg_match('/^\+?\(?\d{3,}\)?([-]?\d+)*$/', $phone)) {
                    // Valid phone number format
                } else {
                    $phone = 'N/A';
                }

                $validationRules = [
                    'username' => 'required',
                    'email' => 'required|email|unique:users,email',
                    'designation' => 'required',
                ];

                $validator = Validator::make($row->toArray(), $validationRules);

                if ($validator->fails()) {
                    foreach ($validator->errors()->all() as $error) {
                        if (str_contains($error, 'email')) {
                            $this->errors[] = "Row " . ($index + 2) . ": The email '" . $row['email'] . "' has already been taken.";
                        } elseif (str_contains($error, 'phone')) {
                            $this->errors[] = "Row " . ($index + 2) . ": The phone number '" . $row['phone'] . "' is invalid.";
                        } else {
                            $this->errors[] = "Row " . ($index + 2) . ": " . $error;
                        }
                    }
                    continue;
                }

                DB::beginTransaction();

                $employee = Employee::create([
                    'designation' => $row['designation'] ?? '',
                    'status' => 'Active',
                    'phone' => $phone,
                    'benefit_amount' => 0,
                    'company_id' => auth('sanctum')->user()->company_id,
                ]);

                $randomPassword = Str::random(8);
                User::create([
                    'name' => $row['username'],
                    'email' => $row['email'],
                    'role' => 'employee',
                    'company_id' => auth('sanctum')->user()->company_id,
                    'employee_id' => $employee->id,
                    'verification_number' => Str::uuid(),
                    'password' => Hash::make($randomPassword),
                ]);

                DB::commit();
            } catch (\Exception $e) {
                DB::rollBack();
                $this->errors[] = "Row " . ($index + 2) . ": " . $e->getMessage();
            }
        }
    }

    /**
     * Get errors collected during import.
     *
     * @return array
     */
    public function getErrors()
    {
        return $this->errors;
    }
}
