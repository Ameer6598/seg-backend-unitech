<?php

namespace App\Http\Controllers\LensManegment;

use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\CompanyLensMaterial;
use App\Http\Controllers\Controller;

class AssignLensMaterial extends Controller
{
    use ApiResponse;

    public function AssignLensMaterialToCompany(Request $request)
    {
        try {
            $request->validate([
                'company_ids' => 'required|array',
                'company_ids.*' => 'required|integer',
                'lens_material_id' => 'required|array',
                'lens_material_id.*' => 'required|integer',
            ]);

            DB::beginTransaction();

            $companyIds = $request->company_ids;
            $lens_material_ids = $request->lens_material_id;
            $newMappings = [];

            foreach ($companyIds as $companyId) {
                foreach ($lens_material_ids as $lens_material_id) {
                    $exists = CompanyLensMaterial::where([
                        'company_id' => $companyId,
                        'lens_material_id' => $lens_material_id,
                    ])->exists();

                    if (!$exists) {
                        $newMappings[] = [
                            'company_id' => $companyId,
                            'lens_material_id' => $lens_material_id,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ];
                    }
                }
            }

            if (!empty($newMappings)) {
                CompanyLensMaterial::insert($newMappings);
            }

            DB::commit();
            return $this->successResponse(['model' => 'company_lens_material'], 'Products assigned to companies successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'company_lens_material'], $e->getMessage(), [], 422);
        }
    }

    public function unassignLensMaterialFromCompany(Request $request)
{
    try {
        $request->validate([
            'company_ids' => 'required|array',
            'company_ids.*' => 'required|integer',
            'lens_material_id' => 'required|array',
            'lens_material_id.*' => 'required|integer',
        ]);

        DB::beginTransaction();

        $companyIds = $request->company_ids;
        $lensMaterialIds = $request->lens_material_id;

        // Delete the specified mappings
        CompanyLensMaterial::whereIn('company_id', $companyIds)
            ->whereIn('lens_material_id', $lensMaterialIds)
            ->delete();

        DB::commit();

        return $this->successResponse(
            ['model' => 'company_lens_material'],
            'Lens materials unassigned from companies successfully',
            []
        );
    } catch (\Exception $e) {
        DB::rollBack();
        return $this->errorResponse(
            ['model' => 'company_lens_material'],
            $e->getMessage(),
            [],
            422
        );
    }
}


}
