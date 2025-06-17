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
        $apiKey = env('MIAL_BOX'); // Ensure correct key name in .env

        if (!$apiKey) {
            $this->errors[] = 'MailboxLayer API key is missing.';
            return;
        }

        foreach ($rows as $index => $row) {
            try {
                // Validate row data
                $validator = Validator::make($row->toArray(), [
                    'username' => 'required',
                    'email' => 'required|email|unique:users,email',
                    'phone' => 'required|unique:employees,phone',
                    'designation' => 'required',
                ]);

                if ($validator->fails()) {
                    foreach ($validator->errors()->all() as $error) {
                        // Customize error messages based on the field
                        if (str_contains($error, 'email')) {
                            $this->errors[] = "Row " . ($index + 2) . ": The email '" . $row['email'] . "' has already been taken.";
                        } elseif (str_contains($error, 'phone')) {
                            $this->errors[] = "Row " . ($index + 2) . ": The phone number '" . $row['phone'] . "' has already been taken.";
                        } else {
                            $this->errors[] = "Row " . ($index + 2) . ": " . $error;
                        }
                    }
                    continue;
                }

                if (Company::where('phone', $row['phone'])->exists()) {
                    $this->errors[] = "Row " . ($index + 2) . ": The phone number '" . $row['phone'] . "' is already in use by a company.";
                    continue;
                }

                $response = Http::get("https://apilayer.net/api/check", [
                    'access_key' => $apiKey,
                    'email' => $row['email'],
                ]);

                if ($response->failed()) {
                    $this->errors[] = "Row " . ($index + 2) . ": Email validation service is unavailable for '" . $row['email'] . "'.";
                    continue;
                }

                $emailData = $response->json();

                if (!isset($emailData['mx_found']) || !$emailData['mx_found'] || !isset($emailData['smtp_check']) || !$emailData['smtp_check']) {
                    $this->errors[] = "Row " . ($index + 2) . ": Invalid or non-existent email address '" . $row['email'] . "'.";
                    continue;
                }

                DB::beginTransaction();

                $employee = Employee::create([
                    'designation' => $row['designation'] ?? '',
                    'status' => 'Active',
                    'phone' => $row['phone'] ?? '',
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