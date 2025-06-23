<?php

namespace App\Http\Controllers\LensManegment;

use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\CompanyBlueLightProtection;

class AssignBlueLightProtection extends Controller
{
    use ApiResponse;

    public function assignBlueLightProtectionToCompany(Request $request)
    {
        try {
            $request->validate([
                'company_ids' => 'required|array',
                'company_ids.*' => 'required|integer',
                'blue_light_protection_ids' => 'required|array',
                'blue_light_protection_ids.*' => 'required|integer',
            ]);

            DB::beginTransaction();

            $companyIds = $request->company_ids;
            $blueLightIds = $request->blue_light_protection_ids;
            $newMappings = [];

            foreach ($companyIds as $companyId) {
                foreach ($blueLightIds as $blueLightId) {
                    $exists = CompanyBlueLightProtection::where([
                        'company_id' => $companyId,
                        'blue_light_protection_id' => $blueLightId,
                    ])->exists();

                    if (!$exists) {
                        $newMappings[] = [
                            'company_id' => $companyId,
                            'blue_light_protection_id' => $blueLightId,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ];
                    }
                }
            }

            if (!empty($newMappings)) {
                CompanyBlueLightProtection::insert($newMappings);
            }

            DB::commit();
            return $this->successResponse(
                ['model' => 'blue_light_protection_mapper'],
                'Blue light protections assigned to companies successfully',
                []
            );
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(
                ['model' => 'blue_light_protection_mapper'],
                $e->getMessage(),
                [],
                422
            );
        }
    }



    
}
