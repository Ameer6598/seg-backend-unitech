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
                    // 'password' => 'required',
                    'designation' => 'required',
                    'benefit_amount' => ['nullable', 'numeric'],
                ]);

                if ($validator->fails()) {
                    $this->errors[] = "Row " . ($index + 2) . ": " . implode(', ', $validator->errors()->all());
                    continue;
                }

                // Manual check for phone number in companies table
                if (Company::where('phone', $row['phone'])->exists()) {
                    $this->errors[] = "Row " . ($index + 2) . ": The phone number is already in use by a company.";
                    continue;
                }


                $response = Http::get("https://apilayer.net/api/check", [
                    'access_key' => $apiKey,
                    'email' => $row['email'],
                ]);

                if ($response->failed()) {
                    $this->errors[] = "Row " . ($index + 2) . ": Email validation service is unavailable.";
                    continue;
                }

                $emailData = $response->json();

                if (!isset($emailData['mx_found']) || !$emailData['mx_found'] || !isset($emailData['smtp_check']) || !$emailData['smtp_check']) {
                    $this->errors[] = "Row " . ($index + 2) . ": Invalid or non-existent email address.";
                    continue;
                }


                DB::beginTransaction();

                // Create Employee
                $employee = Employee::create([
                    'designation' => $row['designation'] ?? '',
                    'status' => $row['status'] ?? '',
                    'phone' => $row['phone'] ?? '',
                    'benefit_amount' => $row['benefit_amount'] ?? 0,
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

                // Create Transaction if benefit_amount is provided
                if (!empty($row['benefit_amount'])) {
                    Transaction::create([
                        'employee_id' => $employee->id,
                        'transaction_type' => 'credit',
                        'amount' => $row['benefit_amount'] ?? 0,
                        'balance' => $row['benefit_amount'] ?? 0,
                        'description' => $row['description'] ?? '',
                    ]);
                }

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











// namespace App\Imports;

// use Illuminate\Support\Collection;
// use Maatwebsite\Excel\Concerns\ToCollection;
// use App\Traits\ApiResponse;
// use App\Models\Employee;
// use App\Models\User;
// use Illuminate\Support\Facades\Hash;
// use Maatwebsite\Excel\Concerns\WithHeadingRow;

// class ImportEmployees implements ToCollection, WithHeadingRow
// {
//     /**
//     * @param Collection $collection
//     */
//     use ApiResponse;
//     private $errors = [];

//     public function collection(Collection $rows)
//     {
//         $validatedRows = [];
//         $rowNumber = 1; // Start row number for better error reporting

//         foreach ($rows as $row) {
//             $rowNumber++;
//             if (empty($row['email']) || empty($row['password']) || empty($row['designation'])) {
//                 $this->errors[] = "Row {$rowNumber}: Missing required fields (email, password, designation).";
//                 continue;
//             }

//             if (!filter_var($row['email'], FILTER_VALIDATE_EMAIL)) {
//                 $this->errors[] = "Row {$rowNumber}: Invalid email format ({$row['email']}).";
//                 continue;
//             }

//             if (User::where('email', $row['email'])->exists()) {
//                 $this->errors[] = "Row {$rowNumber}: Duplicate email found ({$row['email']}).";
//                 continue;
//             }

//             $validatedRows[] = $row; // Add valid rows to this array
//         }

//         // Stop further processing if errors exist
//         if (!empty($this->errors)) {
//             throw new \Exception("Validation errors found: \n" . implode("\n", $this->errors));
//         }

//         // Second Pass: Import all validated rows
//         foreach ($validatedRows as $row) {
//             $employee = Employee::create([
//                 'designation' => $row['designation'],
//                 'company_id' => auth('sanctum')->user()->company_id,

//             ]);

//             User::create([
//                 'name' => $row['name'],
//                 'email' => $row['email'],
//                 'password' => Hash::make($row['password']),
//                 'employee_id' => $employee->id,
//                 'role' => 'employee',
//                 'company_id' => auth('sanctum')->user()->company_id,

//             ]);
//         }
//     }
// }
