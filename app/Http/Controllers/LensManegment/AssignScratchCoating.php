<?php

namespace App\Http\Controllers\LensManegment;

use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\CompanyScratchCoatings;

class AssignScratchCoating extends Controller
{

    use ApiResponse;

    public function assignScratchCoatingToCompany(Request $request)
    {
        try {
            $request->validate([
                'company_ids' => 'required|array',
                'company_ids.*' => 'required|integer',
                'scratch_coating_ids' => 'required|array',
                'scratch_coating_ids.*' => 'required|integer',
            ]);

            DB::beginTransaction();

            $companyIds = $request->company_ids;
            $scratchCoatingIds = $request->scratch_coating_ids;
            $newMappings = [];

            foreach ($companyIds as $companyId) {
                foreach ($scratchCoatingIds as $scratchCoatingId) {
                    $exists = CompanyScratchCoatings::where([
                        'company_id' => $companyId,
                        'scratch_coating_id' => $scratchCoatingId,
                    ])->exists();

                    if (!$exists) {
                        $newMappings[] = [
                            'company_id' => $companyId,
                            'scratch_coating_id' => $scratchCoatingId,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ];
                    }
                }
            }

            if (!empty($newMappings)) {
                CompanyScratchCoatings::insert($newMappings);
            }

            DB::commit();
            return $this->successResponse(
                ['model' => 'company_scratch_coating'],
                'Scratch coatings assigned to companies successfully',
                []
            );
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(
                ['model' => 'company_scratch_coating'],
                $e->getMessage(),
                [],
                422
            );
        }
    }

    public function unassignScratchCoatingFromCompany(Request $request)
    {
        try {
            $request->validate([
                'company_ids' => 'required|array',
                'company_ids.*' => 'required|integer',
                'scratch_coating_ids' => 'required|array',
                'scratch_coating_ids.*' => 'required|integer',
            ]);

            DB::beginTransaction();

            $companyIds = $request->company_ids;
            $scratchCoatingIds = $request->scratch_coating_ids;

            CompanyScratchCoatings::whereIn('company_id', $companyIds)
                ->whereIn('scratch_coating_id', $scratchCoatingIds)
                ->delete();

            DB::commit();

            return $this->successResponse(
                ['model' => 'company_scratch_coating'],
                'Scratch coatings unassigned from companies successfully',
                []
            );
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(
                ['model' => 'company_scratch_coating'],
                $e->getMessage(),
                [],
                422
            );
        }
    }
}
