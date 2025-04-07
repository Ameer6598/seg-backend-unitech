<?php

namespace App\Imports;

use App\Models\Product;
use App\Models\ProductImage;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Illuminate\Support\Str;

class ProductsImport implements ToModel, WithHeadingRow
{
    /**
     * @param array $row
     *
     * @return \Illuminate\Database\Eloquent\Model|null
     */
    public function model(array $row)
    {
        // Create the product record first and get the ID
        $product = Product::create([
            'product_name' => $row['product_name'],
            'description' => $row['description'],
            'category' => $row['category'],
            'color' => $row['color'],
            'frame_sizes' => $row['frame_sizes'],
            'gender' => $this->getGender($row['gender']),
            'age_group' => $row['age_group'],
            'rim_type' => $row['rim_type'],
            'style' => $row['style'],
            'material' => $row['material'],
            'shape' => $row['shape'],
            'eye_size' => $row['eye_size'],
            'manufacturer_name' => $row['manufacturer_name'],
            'price' => $row['price'],
            'available_quantity' => $row['available_quantity'],
            'status' => $this->getStatus($row['status']),
            'product_status' => $this->getProductStatus($row['product_status']),
            'vto' => $row['vto'],
            'brand_name' => $row['brand_name'],
            'model_name' => $row['model_name'],
            'glasses_type' => $row['glasses_type'],
            'lens_size' => $row['lens_size'],
            'temple_size' => $row['temple_size'],
            'bridge_size' => $row['bridge_size'],
            'photo_config_name' => $row['photo_config_name'],
        ]);

        if (isset($row['images']) && !empty($row['images'])) {
            $images = explode(',', $row['images']);
        
            // Ensure the images array is not empty or contains only valid entries
            foreach ($images as $image) {
                $image = trim($image); // Remove spaces if any
                if (!empty($image)) {
                    ProductImage::create([
                        'product_id' => $product->product_id,
                        'image_path' => $image,
                    ]);
                }
            }
        }
        

        return $product;
    }

    private function getGender($gender)
    {
        $gender = strtolower($gender);
        if (in_array($gender, ['male', 'female', 'unisex'])) {
            return ucfirst($gender);
        }
        return 'Male';  // Default to 'Male' if the value is invalid
    }

    private function getStatus($status)
    {
        $status = strtolower($status);
        if ($status == 'active') {
            return 'Active';
        }
        return 'Inactive';  // Default to 'Inactive' if the value is invalid
    }

    private function getProductStatus($status)
    {
        return ($status == 1) ? 1 : 0;  // Convert product_status to 1 or 0
    }
}





// namespace App\Imports;
// use App\Models\Product;
// use Maatwebsite\Excel\Concerns\ToModel;

// use Maatwebsite\Excel\Concerns\WithHeadingRow;
// class ProductsImport implements ToModel, WithHeadingRow

// {
//     /**
//      * @param array $row
//      *
//      * @return \Illuminate\Database\Eloquent\Model|null
//      */
//     public function model(array $row)
//     {
//         return new Product([
//             'product_name' => $row['product_name'],
//             'description' => $row['description'],
//             'category' => $row['category'],
//             'color' => $row['color'],
//             'frame_sizes' => $row['frame_sizes'],
//             'gender' => $this->getGender($row['gender']),
//             'age_group' => $row['age_group'],
//             'rim_type' => $row['rim_type'],
//             'style' => $row['style'],
//             'material' => $row['material'],
//             'shape' => $row['shape'],
//             'eye_size' => $row['eye_size'],
//             'manufacturer_name' => $row['manufacturer_name'],
//             'price' => $row['price'],
//             'available_quantity' => $row['available_quantity'],
//             'status' => $this->getStatus($row['status']),
//             'product_status' => $this->getProductStatus($row['product_status']),
//             'images' => $row['images'], // Assuming you process images separately
//             'vto' => $row['vto'],
//             'brand_name' => $row['brand_name'],
//             'model_name' => $row['model_name'],
//             'glasses_type' => $row['glasses_type'],
//             'lens_size' => $row['lens_size'],
//             'temple_size' => $row['temple_size'],
//             'bridge_size' => $row['bridge_size'],
//             'photo_config_name' => $row['photo_config_name'],
//         ]);
//     }

//     private function getGender($gender)
//     {
//         $gender = strtolower($gender);
//         if (in_array($gender, ['male', 'female', 'unisex'])) {
//             return ucfirst($gender);
//         }
//         return 'Male';  // Default to 'Male' if the value is invalid
//     }

//     private function getStatus($status)
//     {
//         $status = strtolower($status);
//         if ($status == 'active') {
//             return 'Active';
//         }
//         return 'Inactive';  // Default to 'Inactive' if the value is invalid
//     }

//     private function getProductStatus($status)
//     {
//         return ($status == 1) ? 1 : 0;  // Convert product_status to 1 or 0
//     }
// }
