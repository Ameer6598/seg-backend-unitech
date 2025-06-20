<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\LensTypeSubcategories;
use Illuminate\Support\Str;
use App\Traits\ApiResponse;

class LensTypeSubcategoriesController extends Controller
{
    use ApiResponse;

    public function create(Request $request)
    {
        try {
            $request->validate([
                'title' => 'required|string|max:255',
                'description' => 'required|string',
                'image' => 'required|image|max:2048',
            ]);

            $subCategory = new LensTypeSubcategories();
            $subCategory->title = $request->title;
            $subCategory->description = $request->description ?? '';

            if ($request->hasFile('image')) {

                $imagePath = $this->uploadImage($request);
                $subCategory->image_url = $imagePath;
            }

            $subCategory->save();

            return $this->successResponse(
                ['model' => 'Lens Type SubCategory'],
                'Lens Type Subcategory created successfully.',
                $subCategory,
                201
            );
        } catch (\Exception $e) {
            return $this->errorResponse(
                ['model' => 'Lens Type SubCategory'],
                'Something went wrong while creating Lens Type Subcategory.',
                ['error' => $e->getMessage()],
                500
            );
        }
    }

    public function get()
    {
        try {
            $subCategories = LensTypeSubcategories::all();

            return $this->successResponse(
                ['model' => 'Lens Type SubCategory'],
                'Lens Type Subcategories retrieved successfully.',
                $subCategories,
                200
            );
        } catch (\Exception $e) {
            return $this->errorResponse(
                ['model' => 'Lens Type SubCategory'],
                'Something went wrong while retrieving Lens Type Subcategories.',
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
                'description' => 'required|string',
                'image' => 'nullable|image|max:2048',
            ]);

            $subCategory = LensTypeSubcategories::findOrFail($id);
            $subCategory->title = $request->title;
            $subCategory->description = $request->description ?? '';

            if ($request->hasFile('image')) {
                // Delete old image if exists
                if ($subCategory->image_url && file_exists(public_path('projectimages/' . $subCategory->image_url))) {
                    unlink(public_path('projectimages/' . $subCategory->image_url));
                }

                $imagePath = $this->uploadImage($request);
                $subCategory->image_url = $imagePath;
            }

            $subCategory->save();

            return $this->successResponse(
                ['model' => 'Lens Type SubCategory'],
                'Lens Type Subcategory updated successfully.',
                $subCategory,
                200
            );
        } catch (\Exception $e) {
            return $this->errorResponse(
                ['model' => 'Lens Type SubCategory'],
                'Something went wrong while updating Lens Type Subcategory.',
                ['error' => $e->getMessage()],
                500
            );
        }
    }

    public function delete($id)
    {
        try {
            $subCategory = LensTypeSubcategories::findOrFail($id);

            // Delete associated image if exists
            if ($subCategory->image_url && file_exists(public_path('projectimages/' . $subCategory->image_url))) {
                unlink(public_path('projectimages/' . $subCategory->image_url));
            }

            $subCategory->delete();

            return $this->successResponse(
                ['model' => 'Lens Type SubCategory'],
                'Lens Type Subcategory deleted successfully.',
                null,
                200
            );
        } catch (\Exception $e) {
            return $this->errorResponse(
                ['model' => 'Lens Type SubCategory'],
                'Something went wrong while deleting Lens Type Subcategory.',
                ['error' => $e->getMessage()],
                500
            );
        }
    }




    private function uploadImage(Request $request)
    {

        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = Str::random(20) . '.' . $image->getClientOriginalExtension();

            $destinationPath = public_path('projectimages/lenstypesubcategories');

            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0755, true);
            }

            $image->move($destinationPath, $imageName);

            return 'lenstypesubcategories/' . $imageName;
        }

        return null;
    }
}
