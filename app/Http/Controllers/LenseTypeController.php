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
                'light_image' => 'required|image|max:2048',
                'dark_image' => 'required|image|max:2048',
            ]);

            // Upload both images
            $lightImagePath = $this->uploadImage($request, 'light_image');
            $darkImagePath = $this->uploadImage($request, 'dark_image');

            $lensType = new LensTypeCategories();
            $lensType->title = $request->title;
            $lensType->light_image_url = $lightImagePath;
            $lensType->dark_image_url = $darkImagePath;
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

            // Get the MEDIA_URL from the .env file
            $baseUrl = env('MEDIA_URL');

            // Append MEDIA_URL to image paths
            $lensTypes->transform(function ($item) use ($baseUrl) {
                if ($item->light_image_url) {
                    $item->light_image_url = $baseUrl . $item->light_image_url;
                }

                if ($item->dark_image_url) {
                    $item->dark_image_url = $baseUrl . $item->dark_image_url;
                }

                return $item;
            });

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
                'light_image' => 'nullable|image|max:2048',
                'dark_image' => 'nullable|image|max:2048',
            ]);
            $lensType = LensTypeCategories::findOrFail($id);

            $lensType->title = $request->title;

            // Handle light image update
            if ($request->hasFile('light_image')) {
                // Delete old light image if exists
                if ($lensType->light_image_url) {
                    $oldLightImagePath = public_path('projectimages/' . $lensType->light_image_url);
                    if (file_exists($oldLightImagePath)) {
                        unlink($oldLightImagePath);
                    }
                }
                // Upload new light image
                $lightImagePath = $this->uploadImage($request, 'light_image');
                $lensType->light_image_url = $lightImagePath;
            }

            // Handle dark image update
            if ($request->hasFile('dark_image')) {
                // Delete old dark image if exists
                if ($lensType->dark_image_url) {
                    $oldDarkImagePath = public_path('projectimages/' . $lensType->dark_image_url);
                    if (file_exists($oldDarkImagePath)) {
                        unlink($oldDarkImagePath);
                    }
                }
                // Upload new dark image
                $darkImagePath = $this->uploadImage($request, 'dark_image');
                $lensType->dark_image_url = $darkImagePath;
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

            // Delete light image if exists
            if ($lensType->light_image_url) {
                $oldLightImagePath = public_path('projectimages/' . $lensType->light_image_url);
                if (file_exists($oldLightImagePath)) {
                    unlink($oldLightImagePath);
                }
            }

            // Delete dark image if exists
            if ($lensType->dark_image_url) {
                $oldDarkImagePath = public_path('projectimages/' . $lensType->dark_image_url);
                if (file_exists($oldDarkImagePath)) {
                    unlink($oldDarkImagePath);
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
    private function uploadImage(Request $request, $fieldName = 'image')
    {
        if ($request->hasFile($fieldName)) {
            $image = $request->file($fieldName);
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
