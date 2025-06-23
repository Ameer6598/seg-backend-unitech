<?php

namespace App\Http\Controllers;

use App\Traits\ApiResponse;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\LensTypeCategories;
use Illuminate\Support\Facades\DB;
use App\Models\LensTypeSubcategories;
use App\Models\CompanyLensTypeSubcategories;

class LensTypeSubcategoriesController extends Controller
{
    use ApiResponse;

    public function create(Request $request)
    {
        try {
            $request->validate([
                'title' => 'required|string|max:255',
                'description' => 'required|string',
                'light_image' => 'required|image|max:2048',
                'dark_image' => 'required|image|max:2048',
                'category_id' => 'required', // assuming the parent table is lens_type_categories
            ]);

            $subCategory = new LensTypeSubcategories();
            $subCategory->title = $request->title;
            $subCategory->description = $request->description ?? '';
            $subCategory->category_id = $request->category_id;

            // Upload light image
            if ($request->hasFile('light_image')) {
                $lightImagePath = $this->uploadImage($request, 'light_image');
                $subCategory->light_image_url = $lightImagePath;
            }

            // Upload dark image
            if ($request->hasFile('dark_image')) {
                $darkImagePath = $this->uploadImage($request, 'dark_image');
                $subCategory->dark_image_url = $darkImagePath;
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

            // Get base URL from .env
            $baseUrl = env('MEDIA_URL');

            // Append MEDIA_URL to image fields
            $subCategories->transform(function ($item) use ($baseUrl) {
                if ($item->light_image_url) {
                    $item->light_image_url = $baseUrl . $item->light_image_url;
                }

                if ($item->dark_image_url) {
                    $item->dark_image_url = $baseUrl . $item->dark_image_url;
                }

                return $item;
            });

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
                'light_image' => 'nullable|image|max:2048',
                'dark_image' => 'nullable|image|max:2048',
                'category_id' => 'required', // add this line
            ]);

            $subCategory = LensTypeSubcategories::findOrFail($id);
            $subCategory->title = $request->title;
            $subCategory->description = $request->description ?? '';
            $subCategory->category_id = $request->category_id; // assign category_id

            // Handle light image update
            if ($request->hasFile('light_image')) {
                // Delete old light image if exists
                if ($subCategory->light_image_url && file_exists(public_path('projectimages/' . $subCategory->light_image_url))) {
                    unlink(public_path('projectimages/' . $subCategory->light_image_url));
                }
                // Upload new light image
                $lightImagePath = $this->uploadImage($request, 'light_image');
                $subCategory->light_image_url = $lightImagePath;
            }

            // Handle dark image update
            if ($request->hasFile('dark_image')) {
                // Delete old dark image if exists
                if ($subCategory->dark_image_url && file_exists(public_path('projectimages/' . $subCategory->dark_image_url))) {
                    unlink(public_path('projectimages/' . $subCategory->dark_image_url));
                }
                // Upload new dark image
                $darkImagePath = $this->uploadImage($request, 'dark_image');
                $subCategory->dark_image_url = $darkImagePath;
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




    // ✅ Separate image upload function
    private function uploadImage(Request $request, $fieldName = 'image')
    {
        if ($request->hasFile($fieldName)) {
            $image = $request->file($fieldName);
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


    public function assignLensTypeSubcategoriesToCompanies(Request $request)
    {
        try {
            $request->validate([
                'company_ids' => 'required|array',
                'company_ids.*' => 'required|integer',
                'sub_cate_ids' => 'required|array',
                'sub_cate_ids.*' => 'required|integer',
            ]);

            DB::beginTransaction();

            $companyIds = $request->company_ids;
            $subCateIds = $request->sub_cate_ids;
            $newMappings = [];

            foreach ($companyIds as $companyId) {
                foreach ($subCateIds as $subCateId) {

                    $subcategory = LensTypeSubcategories::find($subCateId);

                    if ($subcategory) {
                        $categoryId = $subcategory->category_id;

                        $exists = CompanyLensTypeSubcategories::where([
                            'company_id' => $companyId,
                            'sub_cate_id' => $subCateId,
                            'category_id' => $categoryId,
                        ])->exists();

                        if (!$exists) {
                            $newMappings[] = [
                                'company_id' => $companyId,
                                'sub_cate_id' => $subCateId,
                                'category_id' => $categoryId,
                                'created_at' => now(),
                                'updated_at' => now(),
                            ];
                        }
                    }
                }
            }

            if (!empty($newMappings)) {
                CompanyLensTypeSubcategories::insert($newMappings);
            }

            DB::commit();

            return $this->successResponse(
                ['model' => 'CompanyLensTypeSubcategories'],
                'Lens type subcategories assigned to companies successfully.',
                []
            );
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(
                ['model' => 'CompanyLensTypeSubcategories'],
                $e->getMessage(),
                [],
                422
            );
        }
    }


public function getAssignedLensTypeSubcategoriesForCompany()
{
    try {
        // $companyId = auth('sanctum')->user()->company_id;

        $companyId =2;


        $assignedSubcategories = CompanyLensTypeSubcategories::where('company_id', $companyId)->get();
        $grouped = $assignedSubcategories->groupBy('category_id');

        $result = [];

        $mediaUrl = rtrim(env('MEDIA_URL'), '/') . '/';

        foreach ($grouped as $categoryId => $subMappings) {
            $category = LensTypeCategories::find($categoryId);
            if (!$category) continue;

            $subCateIds = $subMappings->pluck('sub_cate_id')->toArray();
            $subCategories = LensTypeSubcategories::whereIn('id', $subCateIds)->get();

            // Add full image URLs to subcategories
            $subCategoryFormatted = $subCategories->map(function ($sub) use ($mediaUrl) {
                return [
                    'id' => $sub->id,
                    'category_id' => $sub->category_id,
                    'title' => $sub->title,
                    'description' => $sub->description,
                    'light_image_url' => $mediaUrl . ltrim($sub->light_image_url, '/'),
                    'dark_image_url' => $mediaUrl . ltrim($sub->dark_image_url, '/'),
                    'created_at' => $sub->created_at,
                    'updated_at' => $sub->updated_at,
                ];
            });

            $result[] = [
                'category_id' => $category->id,
                'category_title' => $category->title ?? null,
                'light_image_url' => $mediaUrl . ltrim($category->light_image_url, '/'),
                'dark_image_url' => $mediaUrl . ltrim($category->dark_image_url, '/'),
                'subcategories' => $subCategoryFormatted,
            ];
        }

        return $this->successResponse(
            ['model' => 'LensTypeCategoriesWithAssignedSubcategories'],
            'Company-wise assigned subcategories fetched successfully.',
            $result
        );
    } catch (\Exception $e) {
        return $this->errorResponse(
            ['model' => 'LensTypeCategoriesWithAssignedSubcategories'],
            $e->getMessage(),
            [],
            500
        );
    }
}




    
}
