<?php

namespace App\Http\Controllers;

use App\Traits\ApiResponse;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\LensTypeCategories;
use Illuminate\Support\Facades\Storage;

class LenseTypeController extends Controller
{

    use ApiResponse;


    public function create(Request $request)
    {
        try {
            $request->validate([
                'title' => 'required|string|max:255',
                'image' => 'required|image|max:2048',
            ]);

            $imagePath = $this->uploadImage($request);

            // Save to database
            $lensType = new LensTypeCategories();
            $lensType->title = $request->title; // keep 'title' as per your schema
            $lensType->image_url = $imagePath;
            $lensType->save();

            return $this->successResponse(
                ['model' => 'Lens Type Category'],
                'Lens Type Category created successfully',
                $lensType,
                201
            );
        } catch (\Exception $e) {
            return $this->errorResponse(
                null,
                'Something went wrong while creating Lens Type Category',
                ['error' => $e->getMessage()],
                500
            );
        }
    }
    public function get()
    {
        try {
            $lensTypes = LensTypeCategories::all();

            return $this->successResponse(
                ['model' => 'Lens Type Category'],
                'Lens Type Categories fetched successfully',
                $lensTypes,
                200
            );
        } catch (\Exception $e) {
            return $this->errorResponse(
                ['model' => 'Lens Type Category'],
                'Something went wrong while fetching Lens Type Categories',
                ['error' => $e->getMessage()],
                500
            );
        }
    }


    public function update(Request $request, $id)
    {


        try {
            $request->validate([
                'title' => 'required|string|max:255',
                'image' => 'nullable|image|max:2048',
            ]);
            $lensType = LensTypeCategories::findOrFail($id);

            $lensType->title = $request->title;

            if ($request->hasFile('image')) {


                if ($lensType->image_url) {
                    $oldImagePath = public_path('projectimages/' . $lensType->image_url);
                    if (file_exists($oldImagePath)) {
                        unlink($oldImagePath);
                    }
                }



                $imagePath = $this->uploadImage($request);
                $lensType->image_url = $imagePath;
            }

            $lensType->save();

            return $this->successResponse(
                ['model' => 'Lens Type Category'],
                'Lens Type Category updated successfully',
                $lensType,
                200
            );
        } catch (\Exception $e) {
            return $this->errorResponse(
                ['model' => 'Lens Type Category'],
                'Something went wrong while updating Lens Type Category',
                ['error' => $e->getMessage()],
                500
            );
        }
    }

    public function delete($id)
    {
        try {
            $lensType = LensTypeCategories::findOrFail($id);

            if ($lensType->image_url) {
                $oldImagePath = public_path('projectimages/' . $lensType->image_url);
                if (file_exists($oldImagePath)) {
                    unlink($oldImagePath);
                }
            }



            $lensType->delete();

            return $this->successResponse(
                ['model' => 'Lens Type Category'],
                'Lens Type Category deleted successfully',
                null,
                200
            );
        } catch (\Exception $e) {
            return $this->errorResponse(
                ['model' => 'Lens Type Category'],
                'Something went wrong while deleting Lens Type Category',
                ['error' => $e->getMessage()],
                500
            );
        }
    }


    // ✅ Separate image upload function
    private function uploadImage(Request $request)
    {
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = Str::random(20) . '.' . $image->getClientOriginalExtension();

            $destinationPath = public_path('projectimages/lenstypecategories');

            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0755, true);
            }

            $image->move($destinationPath, $imageName);

            return 'lenstypecategories/' . $imageName;
        }

        return null;
    }
}
