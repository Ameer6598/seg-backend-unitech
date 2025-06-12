<?php

namespace App\Http\Controllers\LensManegment;

use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use App\Models\Companylenstint;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;

class AssignLenstint extends Controller
{
    use ApiResponse;

    public function assignLensTintToCompany(Request $request)
    {
        try {
            $request->validate([
                'company_ids' => 'required|array',
                'company_ids.*' => 'required|integer',
                'lens_tint_ids' => 'required|array',
                'lens_tint_ids.*' => 'required|integer',
            ]);

            DB::beginTransaction();

            $companyIds = $request->company_ids;
            $lensTintIds = $request->lens_tint_ids;
            $newMappings = [];

            foreach ($companyIds as $companyId) {
                foreach ($lensTintIds as $lensTintId) {
                    $exists = Companylenstint::where([
                        'company_id' => $companyId,
                        'lens_tint_id' => $lensTintId,
                    ])->exists();

                    if (!$exists) {
                        $newMappings[] = [
                            'company_id' => $companyId,
                            'lens_tint_id' => $lensTintId,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ];
                    }
                }
            }

            if (!empty($newMappings)) {
                Companylenstint::insert($newMappings);
            }

            DB::commit();
            return $this->successResponse(
                ['model' => 'company_lens_tint'],
                'Lens tints assigned to companies successfully',
                []
            );
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(
                ['model' => 'company_lens_tint'],
                $e->getMessage(),
                [],
                422
            );
        }
    }
}
