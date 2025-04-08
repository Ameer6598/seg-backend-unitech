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
use App\Models\Manufacturer;
use App\Models\ProductImage;
use Illuminate\Http\Request;
use App\Models\CompanyProduct;
use App\Imports\ProductsImport;
use App\Models\EmployeeProduct;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    use ApiResponse;
    use Common;



    public function create(Request $request)
    {

        try {
            $request->validate([
                'product_name' => 'required|string|max:255',
                'description' => 'required|string',
                'category' => 'required|numeric',
                'color' => 'required|numeric',
                'frame_sizes' => 'required|numeric',
                'gender' => 'required',
                'rim_type' => 'required|numeric',
                'material' => 'required|numeric',
                'manufacturer_name' => 'required|numeric',
                'price' => 'required|numeric|min:0',
                'available_quantity' => 'required|integer|min:0',
                'status' => 'required|numeric',
                'images.*' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            ]);



            DB::beginTransaction();

            $product = Product::create($request->except('images'));


            if ($request->hasFile('images')) {
                foreach ($request->file('images') as $image) {
                    $imagePath = $this->uploadImages($image, 'products'); // Uploading function ko call karna
                    ProductImage::create([
                        'product_id' => $product->product_id, // Yahan `product_id` set karein
                        'image_path' => $imagePath,   // Image ka path store karein
                    ]);
                }
            }
            $companies = DB::table('companies')->select('id')->get();
            $mappings = $companies->map(function ($company) use ($product) {
                return [
                    'product_id' => $product->product_id,
                    'company_id' => $company->id,
                    'created_at' => now(),
                ];
            })->toArray();

            CompanyProduct::insert($mappings);

            DB::commit();
            return $this->successResponse(['model' => 'products'], 'Product created successfully', [
                'product' => $product,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'products'], $e->getMessage(), [], 422);
        }
    }



    public function update(Request $request)
    {
        try {
            $request->validate([
                'product_name' => 'required|string|max:255',
                'description' => 'required|string',
                'category' => 'required|numeric',
                'color' => 'required|numeric',
                'frame_sizes' => 'required|numeric',
                'gender' => 'required',
                'rim_type' => 'required|numeric',
                'material' => 'required|numeric',
                'manufacturer_name' => 'required|numeric',
                'price' => 'required|numeric|min:0',
                'available_quantity' => 'required|integer|min:0',
                'status' => 'required|numeric',
                'images.*' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                'product_id' => 'required',
                'image_ids' => 'nullable|array', // Array of image IDs to delete
                'image_ids.*' => 'nullable|numeric', // Individual image IDs to delete
            ]);




            DB::beginTransaction();

            $product = Product::findOrFail($request->product_id);

            // Delete images provided in the request
            if ($request->has('image_ids')) {
                foreach ($request->image_ids as $imageId) {
                    $image = ProductImage::find($imageId);
                    if ($image) {
                        $this->unlinkImage($image->image_path); // Unlink the image from the filesystem
                        $image->delete(); // Remove the image from the database
                    }
                }
            }

            // Images ko separately save karna
            if ($request->hasFile('images')) {
                foreach ($request->file('images') as $image) {
                    $imagePath = $this->uploadImages($image, 'products'); // Uploading function ko call karna
                    ProductImage::create([
                        'product_id' => $product->product_id, // Yahan `product_id` set karein
                        'image_path' => $imagePath,   // Image ka path store karein
                    ]);
                }
            }

            // Update the product with new data (excluding images and image IDs)
            $product->update(array_merge(
                $request->except('images', 'image_ids'), // Exclude images and image_ids from update
            ));

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
                    ->where('product_status', 1)
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
                    'images:id,product_id,image_path',
                    'productcategory:category_id,category_name',
                    'productcolor:color_id,color_name',
                    'framezie:frame_size_id,frame_size_name',
                    'rimtype:rim_type_id,rim_type_name',
                    'material:material_id,material_name',
                    'shape:shape_id,shape_name',
                    'style:style_id,style_name',
                    'manufacturer'
                ])
                    ->where('product_status', 1)
                    ->get();


                // Add base URL to image paths
                $products->map(function ($product) use ($mediaURL) {
                    $product->images->map(function ($image) use ($mediaURL) {
                        $image->image_path = $mediaURL . $image->image_path;
                        return $image;
                    });
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
            $productIds = CompanyProduct::where('company_id', $companyId)
                ->pluck('product_id'); // Just get array of product IDs

                $mediaURL = env('BASE_URL');

            $products = Product::with([
                'images:id,product_id,image_path',
                'productcategory:category_id,category_name',
                'productcolor:color_id,color_name',
                'framezie:frame_size_id,frame_size_name',
                'rimtype:rim_type_id,rim_type_name',
                'material:material_id,material_name',
                'shape:shape_id,shape_name',
                'style:style_id,style_name',
                'manufacturer'
            ])
                ->where('product_status', 1)
                ->get();


                $products->map(function ($product) use ($mediaURL) {
                    $product->images->map(function ($image) use ($mediaURL) {
                        $image->image_path = $mediaURL . $image->image_path;
                        return $image;
                    });
                    return $product;
                });

            return $this->successResponse(['model' => 'products'], 'Product retrieved successfully', [
                'products' => $products,
            ]);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'products'], $e->getMessage(), [], 422);
        }
    }

    public function getemployeeProducts()
    {
        try {
            $employeeId = auth('sanctum')->user()->employee_id;
            $productIds = EmployeeProduct::where('employee_id', $employeeId)
                ->pluck('product_id'); // Just get array of product IDs

                $mediaURL = env('BASE_URL');

            $products = Product::with([
                'images:id,product_id,image_path',
                'productcategory:category_id,category_name',
                'productcolor:color_id,color_name',
                'framezie:frame_size_id,frame_size_name',
                'rimtype:rim_type_id,rim_type_name',
                'material:material_id,material_name',
                'shape:shape_id,shape_name',
                'style:style_id,style_name',
                'manufacturer'
            ])
                ->where('product_status', 1)
                ->get();

                $products->map(function ($product) use ($mediaURL) {
                    $product->images->map(function ($image) use ($mediaURL) {
                        $image->image_path = $mediaURL . $image->image_path;
                        return $image;
                    });
                    return $product;
                });



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
            $product->product_status = 0;
            $product->save();


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
            'rim_types' => Style::all(),
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

        $originalName = $image->getClientOriginalName();
        $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);

        $image->move($destinationPath, $fileName);

        if (file_exists("$destinationPath/$fileName")) {
            return "projectimages/{$directory}/{$fileName}";
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

        // return $request;

        $request->validate([
            'file' => 'required|mimes:csv,txt'
        ]);

        // dd($request->file('file'));


        // Import the CSV file
        Excel::import(new ProductsImport, $request->file('file'));

        // Return a JSON response indicating success
        return response()->json([
            'success' => true,
            'message' => 'Data imported successfully.',
        ]);
    }
}











//                    ->map(function ($product) {
//     return [
//         'product_id' => $product->product_id,
//         'product_name' => $product->product_name,
//         'description' => $product->description,
//         'category' => $product->productcategory->category_name ?? null,
//         'color' => $product->productcolor->color_name ?? null,
//         'frame_sizes' => $product->framezie->frame_size_name ?? null,
//         'gender' => $product->gender,
//         'age_group' => $product->age_group,
//         'rim_type' => $product->rimtype->rim_type_name ?? null,
//         'style' => $product->style,
//         'material' => $product->material->material_name,
//         'shape' => $product->shape->shape_name,
//         'eye_size' => $product->eye_size,
//         'manufacturer_name' => $product->manufacturer_name,
//         'price' => $product->price,
//         'available_quantity' => $product->available_quantity,
//         'status' => $product->status,
//         'product_status' => $product->product_status,
//         'created_at' => $product->created_at->format('Y-m-d H:i:s'),
//         'updated_at' => $product->updated_at->format('Y-m-d H:i:s'),
//         'images' => $product->images,
//         'manufacturer' => $product->manufacturer
//     ];
// });





                // $productss = DB::table('products')
                //     ->leftJoin('categories', 'products.category', '=', 'categories.category_id')
                //     ->leftJoin('colors', 'products.color', '=', 'colors.color_id')
                //     ->leftJoin('frame_sizes', 'products.frame_sizes', '=', 'frame_sizes.frame_size_id')
                //     ->leftJoin('rim_types', 'products.rim_type', '=', 'rim_types.rim_type_id')
                //     ->leftJoin('styles', 'products.style', '=', 'styles.style_id')
                //     ->leftJoin('materials', 'products.material', '=', 'materials.material_id')
                //     ->leftJoin('shapes', 'products.shape', '=', 'shapes.shape_id')
                //     ->leftJoin('manufacturers', 'products.manufacturer_name', '=', 'manufacturers.manufacturer_id') // Fixed this line

                //     ->where('products.product_status', 1)
                //     ->select(
                //         'products.*',
                //         'categories.category_name as category',
                //         'colors.color_name as color',
                //         'frame_sizes.frame_size_name as frame_sizes',
                //         'rim_types.rim_type_name as rim_type',
                //         'styles.style_name as style',
                //         'materials.material_name as material',
                //         'shapes.shape_name as shape',

                //         'manufacturers.manufacturer_name as manufacturer' // Cleaned alias
                //     )
                //     ->get();