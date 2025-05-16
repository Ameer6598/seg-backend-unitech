<?php

namespace App\Http\Controllers;

use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\EmployeTempOrderdetail;

class TempOrderController extends Controller
{
    use ApiResponse;

    public function saveOrderDetails(Request $request)
    {
        DB::beginTransaction();

        try {
            $employeeId = auth('sanctum')->user()->employee_id;
            $step = $request->input('step');

            if ($step == 1) {
                $request->validate([
                    'frame_type' => 'required|string|max:255',
                    'frame_prescription' => 'required|string|max:255',
                    'prescription_image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
                    'od_left_sphere' => 'required|string|max:10',
                    'od_left_cylinders' => 'required|string|max:10',
                    'od_left_axis' => 'required|string|max:10',
                    'od_left_nv_add' => 'required|string|max:10',
                    'od_left_2_pds' => 'required|string|max:10',
                    'od_right_sphere' => 'required|string|max:10',
                    'od_right_cylinders' => 'required|string|max:10',
                    'od_right_axis' => 'required|string|max:10',
                    'od_right_nv_add' => 'required|string|max:10',
                    'od_right_2_pds' => 'required|string|max:10',
                    'pupil_distance' => 'required|string',

                ]);

                $temorderdetails = EmployeTempOrderdetail::firstOrNew([
                    'employee_id' => $employeeId
                ]);

                $temorderdetails->fill($request->only([
                    'frame_type',
                    'frame_prescription',
                    'od_left_sphere',
                    'od_left_cylinders',
                    'od_left_axis',
                    'od_left_nv_add',
                    'od_left_2_pds',
                    'od_right_sphere',
                    'od_right_cylinders',
                    'od_right_axis',
                    'od_right_nv_add',
                    'od_right_2_pds',
                    'pupil_distance',
                ]));

                if ($request->hasFile('prescription_image')) {

                    if (!empty($temorderdetails->prescription_image)) {
                        $oldImagePath = public_path($temorderdetails->prescription_image);
                        if (file_exists($oldImagePath)) {
                            unlink($oldImagePath);
                        }
                    }

                    $temorderdetails->prescription_image = $this->uploadImages($request->file('prescription_image'), 'prescriptions');
                }



                $temorderdetails->save();
            } elseif ($step == 2) {
                $request->validate([
                    'frame_picture' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
                    'pupil_distance_online' => 'nullable|string',
                    'od_left_2_pds_online' => 'nullable|string|max:10',
                    'od_right_2_pds_online' => 'nullable|string|max:10',
                ]);

                $temorderdetails = EmployeTempOrderdetail::firstOrNew([
                    'employee_id' => $employeeId
                ]);

                $temorderdetails->fill($request->only([
                    'pupil_distance_online',
                    'od_left_2_pds_online',
                    'od_right_2_pds_online',
                ]));

                if ($request->hasFile('frame_picture')) {
                    if (!empty($temorderdetails->frame_picture)) {
                        $oldImagePath = public_path($temorderdetails->frame_picture);
                        if (file_exists($oldImagePath)) {
                            unlink($oldImagePath);
                        }
                    }

                    $temorderdetails->frame_picture = $this->uploadImages($request->file('frame_picture'), 'frames');
                }


                $temorderdetails->save();
            } else {
                return $this->errorResponse(null, 'Invalid step provided', [], 400);
            }

            DB::commit();

            return $this->successResponse(null, 'Order details saved successfully', $temorderdetails);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(null, 'Something went wrong', ['error' => $e->getMessage()], 500);
        }
    }




    public function getEmployeeOrderDetails(Request $request)
    {
        try {
            $employeeId = auth('sanctum')->user()->employee_id;

            $orderDetails = EmployeTempOrderdetail::where('employee_id', $employeeId)->first();

            return $this->successResponse(
                null,
                'Order details fetched successfully',
                $orderDetails
            );
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'products'], 'Failed to fetch order details', ['error' => $e->getMessage()], 500);
        }
    }



    private function uploadImages($image, $directory = 'products')
    {
        $destinationPath = public_path("projectimages/{$directory}");

        if (!file_exists($destinationPath)) {
            mkdir($destinationPath, 0777, true);
        }

        $originalName = $image->getClientOriginalName();
        $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);

        $image->move($destinationPath, $fileName);

        if (file_exists("$destinationPath/$fileName")) {
            return "/projectimages/{$directory}/{$fileName}";
        } else {
            dd("Image move failed: $fileName");
        }
    }
}
