<?php

namespace App\Http\Controllers\LensManegment;

use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\CompanyLensProtection;

class AssignLensProtection extends Controller
{
   use ApiResponse;

    public function assignLensProtectionToCompany(Request $request)
    {
        try {
            $request->validate([
                'company_ids' => 'required|array',
                'company_ids.*' => 'required|integer',
                'lens_protection_ids' => 'required|array',
                'lens_protection_ids.*' => 'required|integer',
            ]);

            DB::beginTransaction();

            $companyIds = $request->company_ids;
            $lensProtectionIds = $request->lens_protection_ids;
            $newMappings = [];

            foreach ($companyIds as $companyId) {
                foreach ($lensProtectionIds as $lensProtectionId) {
                    $exists = CompanyLensProtection::where([
                        'company_id' => $companyId,
                        'lens_protection_id' => $lensProtectionId,
                    ])->exists();

                    if (!$exists) {
                        $newMappings[] = [
                            'company_id' => $companyId,
                            'lens_protection_id' => $lensProtectionId,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ];
                    }
                }
            }

            if (!empty($newMappings)) {
                CompanyLensProtection::insert($newMappings);
            }

            DB::commit();
            return $this->successResponse(
                ['model' => 'company_lens_protection'],
                'Lens protections assigned to companies successfully',
                []
            );
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(
                ['model' => 'company_lens_protection'],
                $e->getMessage(),
                [],
                422
            );
        }
    }

    public function unassignLensProtectionFromCompany(Request $request)
{
    try {
        $request->validate([
            'company_ids' => 'required|array',
            'company_ids.*' => 'required|integer',
            'lens_protection_ids' => 'required|array',
            'lens_protection_ids.*' => 'required|integer',
        ]);

        DB::beginTransaction();

        $companyIds = $request->company_ids;
        $lensProtectionIds = $request->lens_protection_ids;

        // Delete the specified mappings
        CompanyLensProtection::whereIn('company_id', $companyIds)
            ->whereIn('lens_protection_id', $lensProtectionIds)
            ->delete();

        DB::commit();

        return $this->successResponse(
            ['model' => 'company_lens_protection'],
            'Lens protections unassigned from companies successfully',
            []
        );
    } catch (\Exception $e) {
        DB::rollBack();
        return $this->errorResponse(
            ['model' => 'company_lens_protection'],
            $e->getMessage(),
            [],
            422
        );
    }
}



}   
