<?php

namespace App\Http\Controllers;

use App\Models\Color;
use App\Models\Shape;
use App\Models\Style;
use App\Traits\Common;
use App\Models\Product;
use App\Models\RimType;
use App\Models\Category;
use App\Models\Material;
use App\Models\FrameSize;
use App\Traits\ApiResponse;
use Illuminate\Support\Str;
use App\Models\Manufacturer;
use App\Models\ProductImage;
use Illuminate\Http\Request;
use App\Models\CompanyProduct;
use App\Imports\ProductsImport;
use App\Models\EmployeeProduct;
use App\Models\ProductVariants;
use App\Models\ProductSubcategory;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

class ProductController extends Controller
{
    use ApiResponse;
    use Common;



    public function create(Request $request)
    {

        try {
            $request->validate([
                'product_name' => 'required|string|max:255',
                'product_tags' => 'nullable|array',
                'product_tags.*' => 'string',
                'description' => 'required|string',
                'sub_category' => 'nullable|numeric',
                'gender' => 'required|string',
                'rim_type' => 'required|numeric',
                'style' => 'required|numeric',
                'material' => 'required|numeric',
                'shape' => 'nullable|string',
                'eye_size' => 'nullable|string',
                'glasses_type' => 'nullable|string',
                'lens_size' => 'nullable|string',
                'temple_size' => 'nullable|string',
                'bridge_size' => 'nullable|string',

                'frame_features' => 'nullable|array',
                'frame_features.*' => 'string',

                'frame_shape' => 'nullable|string',
                'prescriptions_availabel' => 'nullable|string',
                'upc' => 'nullable|string',
                'sku' => 'nullable|string',
                'lens_width' => 'nullable|string',
                'lens_height' => 'nullable|string',
                'frame_width' => 'nullable|string',

                'manufacturer_name' => 'required|numeric',
                'product_status' => 'required|numeric',
                'frame_sizes' => 'required|array', // array will come of this 
                'frame_sizes.*' => 'numeric', // ensuring each frame size id in the array is numeric 
                'product_categories' => 'required|array', // array will come of this 
                'product_categories.*' => 'numeric', // ensuring each frame size id in the array is numeric 


                'featured_image' => 'required|image|max:2048', // Added validation for featured image

                'variants' => 'required|array',
                'variants.*.color_name' => 'required|string',
                'variants.*.price' => 'required|numeric|min:0',
                'variants.*.purchase_price' => 'required|numeric|min:0',
                'variants.*.available_quantity' => 'required|integer|min:0',
                'variants.*.vto' => 'nullable|string',
                'variants.*.photo_config_name' => 'nullable|string',
                'variants.*.images' => 'nullable|array',
                'variants.*.images.*' => 'nullable|image|max:2048',

            ]);




            DB::beginTransaction();

            // Save main product
            $input = $request->except('variants', 'product_tags', 'frame_sizes', 'product_categories', 'frame_features');
            if ($request->has('product_tags')) {
                $input['product_tags'] = implode(',', $request->product_tags);
            }
            if ($request->has('frame_features')) {
                $input['frame_features'] = implode(',', $request->frame_features);
            }
            if ($request->hasFile('featured_image')) {
                $input['featured_image'] = $this->uploadImages($request->file('featured_image'), 'products');
            }

            $product = Product::create($input);

            foreach ($request->variants as $variant) {
                $variantData = [
                    'product_id' => $product->product_id,
                    'color_name' => $variant['color_name'],
                    'price' => $variant['price'],
                    'purchase_price' => $variant['purchase_price'],
                    'available_quantity' => $variant['available_quantity'],
                    'vto' => $variant['vto'] ?? null,
                    'photo_config_name' => $variant['photo_config_name'] ?? null,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];

                $productVariant = ProductVariants::create($variantData);


                if (!empty($variant['images'])) {
                    foreach ($variant['images'] as $image) {
                        $imagePath = $this->uploadImages($image, 'products');
                        ProductImage::create([
                            'variant_id' => $productVariant->id,
                            'image_path' => $imagePath,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);
                    }
                }
            }

            if ($request->has('frame_sizes')) {
                $product->frameSizes()->attach($request->frame_sizes);
            }
            if ($request->has('product_categories')) {
                $product->productCategories()->attach($request->product_categories);
            }


            // $companies = DB::table('companies')->select('id')->get();
            // $mappings = $companies->map(function ($company) use ($product) {
            //     return [
            //         'product_id' => $product->product_id,
            //         'company_id' => $company->id,
            //         'created_at' => now(),
            //     ];
            // })->toArray();

            // CompanyProduct::insert($mappings);

            DB::commit();
            return $this->successResponse(['model' => 'products'], 'Product created successfully', [
                'product' => $product,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'products'], $e->getMessage(), [], 422);
        }
    }

    public function update(Request $request, $id)
    {

        try {
            $request->validate([
                'product_name' => 'required|string|max:255',
                'product_tags' => 'nullable|array',
                'product_tags.*' => 'string',
                'description' => 'required|string',

                'sub_category' => 'nullable|numeric',
                'gender' => 'required|string',
                'rim_type' => 'required|numeric',
                'style' => 'required|numeric',
                'material' => 'required|numeric',
                'shape' => 'nullable|string',
                'eye_size' => 'nullable|string',
                'glasses_type' => 'nullable|string',
                'lens_size' => 'nullable|string',
                'temple_size' => 'nullable|string',
                'bridge_size' => 'nullable|string',

                'frame_features' => 'nullable|array',
                'frame_features.*' => 'string',

                'frame_shape' => 'nullable|string',
                'prescriptions_availabel' => 'nullable|string',
                'upc' => 'nullable|string',
                'sku' => 'nullable|string',
                'lens_width' => 'nullable|string',
                'lens_height' => 'nullable|string',
                'frame_width' => 'nullable|string',

                'manufacturer_name' => 'required|numeric',
                'product_status' => 'required|numeric',
                'frame_sizes' => 'required|array',
                'frame_sizes.*' => 'numeric',
                'product_categories' => 'required|array', // array will come of this 
                'product_categories.*' => 'numeric', // ensuring each frame size id in the array is numeric 
                'featured_image' => 'nullable|image|max:2048', // Added validation for featured image


                'variants' => 'required|array',
                'variants.*.id' => 'nullable|numeric',
                'variants.*.color_name' => 'required|string',
                'variants.*.price' => 'required|numeric|min:0',
                'variants.*.purchase_price' => 'required|numeric|min:0',
                'variants.*.available_quantity' => 'required|integer|min:0',
                'variants.*.vto' => 'nullable|string',
                'variants.*.photo_config_name' => 'nullable|string',
                'variants.*.images' => 'nullable|array',
                'variants.*.images.*' => 'nullable|image|max:2048',
                'variants.*.deleted_images' => 'nullable|array',
                'variants.*.deleted_images.*' => 'numeric',
            ]);
            DB::beginTransaction();

            $product = Product::findOrFail($id);

            // Update main product
            $input = $request->except('variants', 'product_tags', 'frame_sizes', 'product_categories', 'frame_features', 'featured_image');


            if ($request->has('product_tags')) {
                $input['product_tags'] = implode(',', $request->product_tags);
            }

            if ($request->has('frame_features')) {
                $input['frame_features'] = implode(',', $request->frame_features);
            }

            if ($request->hasFile('featured_image')) {
                // Delete old featured image if exists
                if ($product->featured_image) {
                    $fullPath = public_path('/projectimages/products/' . $product->featured_image);
                    if (file_exists($fullPath)) {
                        unlink($fullPath);
                    }
                }
                $input['featured_image'] = $this->uploadImages($request->file('featured_image'), 'products');
            }


            $product->update($input);

            // Update frame sizes
            if ($request->has('frame_sizes')) {
                $product->frameSizes()->sync($request->frame_sizes);
            }

            // Update frame sizes
            if ($request->has('product_categories')) {
                $product->productCategories()->sync($request->product_categories);
            }


            // Get existing variant IDs to detect which ones to delete
            $existingVariantIds = $product->variants->pluck('id')->toArray();
            $updatedVariantIds = [];

            if (!empty($request->variants) && is_array($request->variants)) {
                foreach ($request->variants as $variant) {
                    $variantData = [
                        'color_name' => $variant['color_name'],
                        'price' => $variant['price'],
                        'purchase_price' => $variant['purchase_price'],
                        'available_quantity' => $variant['available_quantity'],
                        'vto' => $variant['vto'] ?? null,
                        'photo_config_name' => $variant['photo_config_name'] ?? null,
                        'updated_at' => now(),
                    ];

                    if (isset($variant['id'])) {
                        // Update existing variant
                        $productVariant = ProductVariants::where('id', $variant['id'])
                            ->where('product_id', $product->product_id)
                            ->firstOrFail();

                        $productVariant->update($variantData);
                        $updatedVariantIds[] = $variant['id'];
                    } else {
                        // Create new variant
                        $variantData['product_id'] = $product->product_id;
                        $variantData['created_at'] = now();
                        $productVariant = ProductVariants::create($variantData);
                        $updatedVariantIds[] = $productVariant->id;
                    }

                    // Handle image deletions
                    if (!empty($variant['deleted_images'])) {
                        $imagesToDelete = ProductImage::where('variant_id', $productVariant->id)
                            ->whereIn('id', $variant['deleted_images'])
                            ->get();

                        foreach ($imagesToDelete as $image) {
                            $fullPath = public_path('projectimages/products/' . $image->image_path);
                            if (file_exists($fullPath)) {
                                unlink($fullPath);
                            }
                            $image->delete();
                        }
                    }

                    // Upload and save new images
                    if (isset($variant['images']) && is_array($variant['images'])) {
                        foreach ($variant['images'] as $image) {
                            if ($image instanceof \Illuminate\Http\UploadedFile && $image->isValid()) {
                                $imagePath = $this->uploadImages($image, 'products');
                                if ($imagePath) {
                                    ProductImage::create([
                                        'variant_id' => $productVariant->id,
                                        'image_path' => $imagePath,
                                        'created_at' => now(),
                                        'updated_at' => now(),
                                    ]);
                                }
                            }
                        }
                    }
                }
            }

            // Delete variants that weren't in the updated list
            $variantsToDelete = array_diff($existingVariantIds, $updatedVariantIds);
            if (!empty($variantsToDelete)) {
                $variants = ProductVariants::whereIn('id', $variantsToDelete)->get();
                foreach ($variants as $variant) {
                    if (!empty($variant->images)) {
                        foreach ($variant->images as $image) {
                            Storage::delete($image->image_path);
                            $image->delete();
                        }
                    }
                    $variant->delete();
                }
            }

            DB::commit();
            return $this->successResponse(['model' => 'products'], 'Product updated successfully', [
                'product' => $product,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'products'], $e->getMessage(), [], 422);
        }
    }



    public function getProductOrAll($productId = null)
    {

        try {
            $baseUrl = config('app.url');
            $mediaURL = env('BASE_URL');

            if ($productId) {
                $product = DB::table('products')
                    ->where('product_id', $productId)
                    ->first();

                if (!$product) {
                    return $this->errorResponse(['model' => 'products'], 'Product not found', [], 404);
                }

                $product->images = $this->processImages($product->images, $baseUrl);

                return $this->successResponse(['model' => 'products'], 'Product retrieved successfully', [
                    'product' => $product,
                ]);
            } else {
                $products = Product::with([
                    'productCategories:category_id,category_name',
                    'productsubcate:id,category_id,subcategory_name',
                    'frameSizes:frame_size_id,frame_size_name',
                    'rimtype:rim_type_id,rim_type_name',
                    'material:material_id,material_name',
                    'shape:shape_id,shape_name',
                    'style:style_id,style_name',
                    'manufacturer',
                    'variants',
                ])

                    ->get();


                // Add base URL to image paths
                $products->map(function ($product) use ($mediaURL) {


                    $product->featured_image = $mediaURL . $product->featured_image;

                    unset($product->sub_category);
                    unset($product->rim_type);
                    unset($product->manufacturer_name);

                    $product->frameSizes->map(function ($frameSize) {
                        unset($frameSize->pivot); // Remove the pivot attribute
                        return $frameSize;
                    });

                    if ($product->productCategories) {
                        $product->productCategories->map(function ($product_categories) {
                            unset($product_categories->pivot);
                            return $product_categories;
                        });
                    }



                    if (!empty($product->product_tags)) {
                        $product->product_tags = collect(explode(',', $product->product_tags))
                            ->map(fn($tag) => ['name' => trim($tag)])
                            ->toArray();
                    } else {
                        $product->product_tags = [];
                    }

                    if (!empty($product->frame_features)) {
                        $product->frame_features = collect(explode(',', $product->frame_features))
                            ->map(fn($tag) => ['name' => trim($tag)])
                            ->toArray();
                    } else {
                        $product->frame_features = [];
                    }




                    // ✅ Add base URL to variant_images
                    foreach ($product->variants as $variant) {
                        if (!empty($variant->variant_images)) {
                            foreach ($variant->variant_images as $image) {
                                $image->image_path = $mediaURL . $image->image_path;
                            }
                        }
                    }



                    return $product;
                });
                return $this->successResponse(['model' => 'products'], 'All products retrieved successfully', [
                    'products' => $products,
                ]);
            }
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'products'], $e->getMessage(), [], 422);
        }
    }


    public function getFullProductDetail($productId)
    {
        try {
            $baseUrl = config('app.url');

            $product = $this->getProductDetails($productId);
            if (!$product) {
                return $this->errorResponse(['model' => 'products'], 'Product not found', [], 404);
            }

            $product->images = $this->processImages($product->images, $baseUrl);

            return $this->successResponse(['model' => 'products'], 'Product retrieved successfully', [
                'product' => $product,
            ]);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'products'], $e->getMessage(), [], 422);
        }
    }


    public function getCompanyProducts()
    {
        try {
            $companyId = auth('sanctum')->user()->company_id;
            $baseUrl = config('app.url');
            $mediaURL = env('BASE_URL');

            $productIds = CompanyProduct::where('company_id', $companyId)
                ->pluck('product_id'); // Get array of product IDs

            $products = Product::with([

                'productCategories:category_id,category_name',
                'productsubcate:id,category_id,subcategory_name',
                'frameSizes:frame_size_id,frame_size_name',
                'rimtype:rim_type_id,rim_type_name',
                'material:material_id,material_name',
                'shape:shape_id,shape_name',
                'style:style_id,style_name',
                'manufacturer',
                'variants'
            ])
                ->whereIn('product_id', $productIds)
                ->where('product_status', 1)
                ->get();

            // Process products and add base URL to image paths
            $products->map(function ($product) use ($mediaURL) {

                $product->featured_image = $mediaURL . $product->featured_image;
                // Remove unnecessary attributes
                unset($product->category);
                unset($product->sub_category);
                unset($product->rim_type);
                unset($product->manufacturer_name);


                // Process frame sizes
                $product->frameSizes->map(function ($frameSize) {
                    unset($frameSize->pivot); // Remove the pivot attribute
                    return $frameSize;
                });


                // Process variant images
                foreach ($product->variants as $variant) {
                    if (!empty($variant->variant_images)) {
                        foreach ($variant->variant_images as $image) {
                            $image->image_path = $mediaURL . $image->image_path;
                        }
                    }
                }

                // Convert tags to array of objects
                if (!empty($product->product_tags)) {
                    $product->product_tags = collect(explode(',', $product->product_tags))
                        ->map(fn($tag) => ['name' => trim($tag)])
                        ->toArray();
                } else {
                    $product->product_tags = [];
                }

                if (!empty($product->frame_features)) {
                    $product->frame_features = collect(explode(',', $product->frame_features))
                        ->map(fn($tag) => ['name' => trim($tag)])
                        ->toArray();
                } else {
                    $product->frame_features = [];
                }



                return $product;
            });

            return $this->successResponse(['model' => 'products'], 'Company products retrieved successfully', [
                'products' => $products,
            ]);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'products'], $e->getMessage(), [], 422);
        }
    }


    


    public function getemployeeProducts(Request $request)
    {
        try {
            $employeeId = auth('sanctum')->user()->employee_id;
            $page = $request->input('page', 1);
            $perPage = $request->input('per_page', 10);

            $productName = $request->input('product_name');
            $manufacturerName = $request->input('manufacturer_name');

            $productIds = EmployeeProduct::where('employee_id', $employeeId)
                ->pluck('product_id');

            $mediaURL = env('BASE_URL');

            $productsQuery = Product::with([
                'productCategories:category_id,category_name',
                'productsubcate:id,category_id,subcategory_name',
                'frameSizes:frame_size_id,frame_size_name',
                'rimtype:rim_type_id,rim_type_name',
                'material:material_id,material_name',
                'shape:shape_id,shape_name',
                'style:style_id,style_name',
                'manufacturer',
                'variants.variant_images', // ensure this relation exists
            ])
                ->where('product_status', 1)
                ->whereIn('product_id', $productIds);

            $isFiltered = false;

            if ($productName) {
                $productsQuery->where('product_name', 'LIKE', "%$productName%");
                $isFiltered = true;
            }

            if ($manufacturerName) {
                $productsQuery->where('manufacturer_name', $manufacturerName);
                $isFiltered = true;
            }

            $products = $isFiltered
                ? $productsQuery->get()
                : $productsQuery->paginate($perPage, ['*'], 'page', $page);

            // Map and format each product
            $collection = $isFiltered ? $products : $products->getCollection();

            $collection->transform(function ($product) use ($mediaURL) {


                $product->featured_image = $mediaURL . $product->featured_image;
                // Remove unnecessary attributes if present
                unset($product->category);
                unset($product->sub_category);
                unset($product->rim_type);
                unset($product->manufacturer_name);

                $product->frameSizes->map(function ($frameSize) {
                    unset($frameSize->pivot);
                    return $frameSize;
                });

                // Format tags
                if (!empty($product->product_tags)) {
                    $product->product_tags = collect(explode(',', $product->product_tags))
                        ->map(fn($tag) => ['name' => trim($tag)])
                        ->toArray();
                } else {
                    $product->product_tags = [];
                }

                if (!empty($product->frame_features)) {
                    $product->frame_features = collect(explode(',', $product->frame_features))
                        ->map(fn($tag) => ['name' => trim($tag)])
                        ->toArray();
                } else {
                    $product->frame_features = [];
                }


                // Add media URL to variant images
                foreach ($product->variants as $variant) {
                    if (!empty($variant->variant_images)) {
                        foreach ($variant->variant_images as $image) {
                            $image->image_path = $mediaURL . $image->image_path;
                        }
                    }
                }

                return $product;
            });

            if (!$isFiltered) {
                $products->setCollection($collection);
            }

            return $this->successResponse(['model' => 'products'], 'Product retrieved successfully', [
                'products' => $products,
            ]);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'products'], $e->getMessage(), [], 422);
        }
    }





    public function deleteProduct($productId)
    {
        try {
            DB::beginTransaction();

            $product = Product::findOrFail($productId);

            $product->frameSizes()->detach();
            $product->productCategories()->detach();


            CompanyProduct::where('product_id', $product->product_id)->delete();
            EmployeeProduct::where('product_id', $product->product_id)->delete();

            $variants = ProductVariants::where('product_id', $product->product_id)->get();

            foreach ($variants as $variant) {

                $images = ProductImage::where('variant_id', $variant->id)->get();

                foreach ($images as $image) {
                    $fullPath = public_path('projectimages/products/' . $image->image_path);

                    if (file_exists($fullPath)) {
                        unlink($fullPath);
                    }

                    $image->delete();
                }

                // Delete variant
                $variant->delete();
            }

            // Finally delete product
            $product->delete();

            DB::commit();
            return $this->successResponse(['model' => 'products'], 'Product deleted successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'products'], $e->getMessage(), [], 422);
        }
    }



    public function getCategories()
    {
        return $this->successResponse(['model' => 'category'], 'Categories fetched successfully', [
            'categories' => Category::all(),
        ]);
    }

    public function createCategory(Request $request)
    {
        $data = $request->validate([
            'category_name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'color' => 'nullable|string|max:50',
        ]);

        try {
            DB::beginTransaction();

            $category = Category::create($data);

            DB::commit();

            return $this->successResponse(['model' => 'category'], 'Category created successfully', [
                'category' => $category,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'category'], $e->getMessage(), [], 422);
        }
    }

    public function updateCategory(Request $request)
    {
        $data = $request->validate([
            'category_name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'color' => 'nullable|string|max:50',
            'category_id' => 'required'
        ]);
        try {
            DB::beginTransaction();
            $category = Category::findOrFail($data['category_id']);

            $category->update($data);

            DB::commit();

            return $this->successResponse(['model' => 'category'], 'Category updated successfully', [
                'category' => $category,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'category'], $e->getMessage(), [], 422);
        }
    }



    public function deleteCategory($id)
    {
        if ($id == 4) {
            return $this->errorResponse(['model' => 'category'], 'This category is hardcoded and cannot be deleted.', [], 403);
        }

        DB::beginTransaction();

        try {
            $category = Category::findOrFail($id);
            $category->delete();

            DB::commit();

            return $this->successResponse(['model' => 'category'], 'Category deleted successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'category'], $e->getMessage(), [], 422);
        }
    }


    public function createSubcategory(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'category_id' => 'required',
            'subcategory_name' => 'required|string|max:255',
        ]);

        if ($validator->fails()) {
            return $this->errorResponse(
                ['model' => 'subcategory'],
                'Validation error',
                $validator->errors(),
                422
            );
        }

        try {
            DB::beginTransaction();
            $subcategory = ProductSubcategory::create($validator->validated());
            DB::commit();

            return $this->successResponse(
                ['model' => 'subcategory'],
                'Subcategory created successfully',
                ['subcategory' => $subcategory]
            );
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(
                ['model' => 'subcategory'],
                $e->getMessage(),
                [],
                422
            );
        }
    }

    public function getSubcategories()
    {
        return $this->successResponse(['model' => 'subcategories'], 'Subcategories fetched successfully', [
            'Subcategories' => ProductSubcategory::all(),
        ]);
    }


    public function updateSubcategory(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'subcategory_name' => 'required|string|max:255',
            'category_id' => 'required',
        ]);

        if ($validator->fails()) {
            return $this->errorResponse(
                ['model' => 'subcategory'],
                'Validation error',
                $validator->errors(),
                422
            );
        }

        try {
            DB::beginTransaction();

            $data = $validator->validated();

            $subcategory = ProductSubcategory::findOrFail($data['id']);
            $subcategory->update([
                'subcategory_name' => $data['subcategory_name'],
                'category_id' => $data['category_id'],
            ]);

            DB::commit();

            return $this->successResponse(
                ['model' => 'subcategory'],
                'Subcategory updated successfully',
                ['subcategory' => $subcategory]
            );
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(
                ['model' => 'subcategory'],
                $e->getMessage(),
                [],
                422
            );
        }
    }


    public function deleteSubcategory($id)
    {
        DB::beginTransaction();

        try {
            $subcategory = ProductSubcategory::findOrFail($id);
            $subcategory->delete();

            DB::commit();

            return $this->successResponse(['model' => 'subcategory'], 'Subcategory deleted successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'subcategory'], $e->getMessage(), [], 422);
        }
    }

    public function getColors()
    {
        return $this->successResponse(['model' => 'color'], 'Colors fetched successfully', [
            'colors' => Color::all(),
        ]);
    }

    public function createColor(Request $request)
    {
        $data = $request->validate([
            'color_name' => 'required|string|max:255',
            'frame_sizes' => 'nullable|string',
        ]);

        DB::beginTransaction();

        try {
            $color = Color::create($data);

            DB::commit();
            return $this->successResponse(['model' => 'color'], 'Color created successfully', [
                'color' => $color,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'color'], $e->getMessage(), [], 422);
        }
    }

    public function updateColor(Request $request)
    {

        $data = $request->validate([
            'color_name' => 'required|string|max:255',
            'frame_sizes' => 'nullable|string',
            'color_id' => 'required'
        ]);

        DB::beginTransaction();

        try {
            $color = Color::findOrFail($request->color_id);

            $color->update($data);

            DB::commit();
            return $this->successResponse(['model' => 'color'], 'Color updated successfully', [
                'color' => $color,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'color'], $e->getMessage(), [], 422);
        }
    }

    public function deleteColor($id)
    {
        if ($id == 4) {
            return $this->errorResponse(['model' => 'color'], 'You cannot delete this color.', [], 403);
        }

        DB::beginTransaction();

        try {
            $color = Color::findOrFail($id);
            $color->delete();

            DB::commit();

            return $this->successResponse(['model' => 'color'], 'Color deleted successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'color'], $e->getMessage(), [], 422);
        }
    }


    public function getFrameSizes()
    {
        return $this->successResponse(['model' => 'frame_size'], 'Frame sizes fetched successfully', [
            'frame_sizes' => FrameSize::all(),
        ]);
    }

    public function createFrameSize(Request $request)
    {
        $data = $request->validate([
            'frame_size_name' => 'required|string|max:255',
            'rim_type' => 'nullable|string',
        ]);

        DB::beginTransaction();

        try {
            $frameSize = FrameSize::create($data);

            DB::commit();

            return $this->successResponse(['model' => 'frame_size'], 'Frame Size created successfully', [
                'frame_size' => $frameSize,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'frame_size'], $e->getMessage(), [], 422);
        }
    }

    public function updateFrameSize(Request $request)
    {

        $data = $request->validate([
            'frame_size_name' => 'required|string|max:255',
            'rim_type' => 'nullable|string',
            'frame_size_id' => 'required'
        ]);

        DB::beginTransaction();

        try {
            $frameSize = FrameSize::findOrFail($data['frame_size_id']);

            $frameSize->update($data);

            DB::commit();

            return $this->successResponse(['model' => 'frame_size'], 'Frame Size updated successfully', [
                'frame_size' => $frameSize,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'frame_size'], $e->getMessage(), [], 422);
        }
    }

    public function deleteFrameSize($id)
    {
        if ($id == 4) {
            return $this->errorResponse(['model' => 'framesize'], 'This framesize is hardcoded and cannot be deleted.', [], 403);
        }



        DB::beginTransaction();
        try {
            $frameSize = FrameSize::findOrFail($id);
            $frameSize->delete();

            DB::commit();

            return $this->successResponse(['model' => 'frame_size'], 'Frame Size deleted successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'frame_size'], $e->getMessage(), [], 422);
        }
    }


    public function getRimTypes()
    {
        return $this->successResponse(['model' => 'frame_size'], 'Rim Types fetched successfully', [
            'rim_types' => RimType::all(),
        ]);
    }

    public function createRimType(Request $request)
    {
        DB::beginTransaction();

        try {
            $data = $request->validate([
                'rim_type_name' => 'required|string|max:255',
                'style' => 'nullable|string',
            ]);

            $rimType = RimType::create($data);

            DB::commit();

            return $this->successResponse(['model' => 'rim_type'], 'Rim Type created successfully', $rimType);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'rim_type'], $e->getMessage(), [], 422);
        }
    }

    public function updateRimType(Request $request)
    {
        DB::beginTransaction();

        try {

            $data = $request->validate([
                'rim_type_name' => 'required|string|max:255',
                'style' => 'nullable|string',
                'rim_type_id' => 'required'
            ]);
            $rimType = RimType::findOrFail($data['rim_type_id']);

            $rimType->update($data);

            DB::commit();

            return $this->successResponse(['model' => 'rim_type'], 'Rim Type updated successfully', $rimType);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'rim_type'], $e->getMessage(), [], 422);
        }
    }

    public function deleteRimType($id)
    {

        if ($id == 4) {
            return $this->errorResponse(['model' => 'rimtype'], 'This rimtype is hardcoded and cannot be deleted.', [], 403);
        }

        DB::beginTransaction();
        try {
            $rimType = RimType::findOrFail($id);
            $rimType->delete();

            DB::commit();

            return $this->successResponse(['model' => 'rim_type'], 'Rim Type deleted successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'rim_type'], $e->getMessage(), [], 422);
        }
    }

    public function getStyles()
    {
        return $this->successResponse(['model' => 'frame_size'], 'Style fetched successfully', [
            'styles' => Style::all(),
        ]);
    }

    public function createStyle(Request $request)
    {
        DB::beginTransaction();

        try {
            $data = $request->validate([
                'style_name' => 'required|string|max:255',
                'material' => 'nullable|string|max:255',
            ]);

            $style = Style::create($data);

            DB::commit();

            return $this->successResponse(['model' => 'style'], 'Style created successfully', $style);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'style'], $e->getMessage(), [], 422);
        }
    }

    public function updateStyle(Request $request)
    {
        DB::beginTransaction();

        try {

            $data = $request->validate([
                'style_name' => 'required|string|max:255',
                'material' => 'nullable|string|max:255',
                'style_id' => 'required'
            ]);
            $style = Style::findOrFail($data['style_id']);

            $style->update($data);

            DB::commit();

            return $this->successResponse(['model' => 'style'], 'Style updated successfully', $style);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'style'], $e->getMessage(), [], 422);
        }
    }

    public function deleteStyle($id)
    {

        if ($id == 4) {
            return $this->errorResponse(['model' => 'style'], 'This style is hardcoded and cannot be deleted.', [], 403);
        }

        DB::beginTransaction();

        try {
            $style = Style::findOrFail($id);
            $style->delete();

            DB::commit();

            return $this->successResponse(['model' => 'style'], 'Style deleted successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'style'], $e->getMessage(), [], 422);
        }
    }

    public function createMaterial(Request $request)
    {
        DB::beginTransaction();

        try {
            $data = $request->validate([
                'material_name' => 'required|string|max:255',
                'shape' => 'nullable|string|max:255',
            ]);

            $material = Material::create($data);

            DB::commit();

            return $this->successResponse(['model' => 'material'], 'Material created successfully', $material);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'material'], $e->getMessage(), [], 422);
        }
    }

    public function getMaterials()
    {
        try {
            $materials = Material::all();
            return $this->successResponse(['model' => 'material'], 'Materials retrieved successfully', $materials);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'material'], $e->getMessage(), [], 422);
        }
    }

    public function updateMaterial(Request $request)
    {
        DB::beginTransaction();

        try {

            $data = $request->validate([
                'material_name' => 'required|string|max:255',
                'shape' => 'nullable|string|max:255',
                'material_id' => 'required'
            ]);

            $material = Material::findOrFail($data['material_id']);

            $material->update($data);

            DB::commit();

            return $this->successResponse(['model' => 'material'], 'Material updated successfully', $material);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'material'], $e->getMessage(), [], 422);
        }
    }

    public function deleteMaterial($id)
    {

        if ($id == 5) {
            return $this->errorResponse(['model' => 'material'], 'This material is hardcoded and cannot be deleted.', [], 403);
        }


        DB::beginTransaction();

        try {
            $material = Material::findOrFail($id);
            $material->delete();

            DB::commit();

            return $this->successResponse(['model' => 'material'], 'Material deleted successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'material'], $e->getMessage(), [], 422);
        }
    }

    public function createShape(Request $request)
    {
        DB::beginTransaction();

        try {
            $data = $request->validate([
                'shape_name' => 'required|string|max:255',
                'manufacturer_name' => 'nullable|string|max:255',
            ]);

            $shape = Shape::create($data);

            DB::commit();

            return $this->successResponse(['model' => 'shape'], 'Shape created successfully', $shape);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'shape'], $e->getMessage(), [], 422);
        }
    }

    public function getShapes()
    {
        try {
            $shapes = Shape::all();
            return $this->successResponse(['model' => 'shape'], 'Shapes retrieved successfully', $shapes);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'shape'], $e->getMessage(), [], 422);
        }
    }

    public function updateShape(Request $request)
    {
        DB::beginTransaction();

        try {

            $data = $request->validate([
                'shape_name' => 'required|string|max:255',
                'manufacturer_name' => 'nullable|string|max:255',
                'shape_id' => 'required'
            ]);
            $shape = Shape::findOrFail($data['shape_id']);

            $shape->update($data);

            DB::commit();

            return $this->successResponse(['model' => 'shape'], 'Shape updated successfully', $shape);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'shape'], $e->getMessage(), [], 422);
        }
    }

    public function deleteShape($id)
    {


        if ($id == 4) {
            return $this->errorResponse(['model' => 'shape'], 'This shape is hardcoded and cannot be deleted.', [], 403);
        }


        DB::beginTransaction();

        try {
            $shape = Shape::findOrFail($id);
            $shape->delete();

            DB::commit();

            return $this->successResponse(['model' => 'shape'], 'Shape deleted successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'shape'], $e->getMessage(), [], 422);
        }
    }

    public function createManufacturer(Request $request)
    {
        DB::beginTransaction();

        try {
            $data = $request->validate([
                'manufacturer_name' => 'required|string|max:255',
                'contact_info' => 'nullable|string',
            ]);

            $manufacturer = Manufacturer::create($data);

            DB::commit();

            return $this->successResponse(['model' => 'manufacturer'], 'Manufacturer created successfully', $manufacturer);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'manufacturer'], $e->getMessage(), [], 422);
        }
    }

    public function getManufacturers()
    {
        try {
            $manufacturers = Manufacturer::all();
            return $this->successResponse(['model' => 'manufacturer'], 'Manufacturers retrieved successfully', $manufacturers);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'manufacturer'], $e->getMessage(), [], 422);
        }
    }

    public function updateManufacturer(Request $request)
    {
        DB::beginTransaction();

        try {

            $data = $request->validate([
                'manufacturer_name' => 'required|string|max:255',
                'contact_info' => 'nullable|string',
                'manufacturer_id' => 'required'
            ]);
            $manufacturer = Manufacturer::findOrFail($data['manufacturer_id']);

            $manufacturer->update($data);

            DB::commit();

            return $this->successResponse(['model' => 'manufacturer'], 'Manufacturer updated successfully', $manufacturer);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'manufacturer'], $e->getMessage(), [], 422);
        }
    }

    public function deleteManufacturer($id)
    {


        if ($id == 3) {
            return $this->errorResponse(['model' => 'manufacturer'], 'This shape is manufacturer and cannot be deleted.', [], 403);
        }


        DB::beginTransaction();

        try {
            $manufacturer = Manufacturer::findOrFail($id);
            $manufacturer->delete();

            DB::commit();

            return $this->successResponse(['model' => 'manufacturer'], 'Manufacturer deleted successfully', []);
        } catch (\Exception $e) {
            DB::rollBack();

            return $this->errorResponse(['model' => 'manufacturer'], $e->getMessage(), [], 422);
        }
    }


    private function uploadImages($image, $directory = 'products')
    {
        $destinationPath = public_path("projectimages/{$directory}");

        if (!file_exists($destinationPath)) {
            mkdir($destinationPath, 0777, true);
        }

        // Get original file extension
        $extension = $image->getClientOriginalExtension();

        // Generate a random unique name
        $fileName = time() . Str::random(10) . '.' . $extension;

        $image->move($destinationPath, $fileName);

        if (file_exists("$destinationPath/$fileName")) {
            return "{$fileName}";
        } else {
            dd("Image move failed: $fileName");
        }
    }


    public function unlinkImage($imagePath)
    {
        $filePath = public_path($imagePath); // Adjust the path as needed
        if (file_exists($filePath)) {
            unlink($filePath); // Remove the file from the server
        }
    }

    private function processImages($images, $baseUrl)
    {
        if (!$images) {
            return [];
        }
        $imagePaths = explode(',', $images);
        return array_map(fn($image) => asset($image), $imagePaths);
    }




    public function upload(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'file' => 'required|mimes:csv,txt',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        Excel::import(new ProductsImport, $request->file('file'));

        return response()->json([
            'success' => true,
            'message' => 'Data imported successfully.',
        ]);
    }
}
