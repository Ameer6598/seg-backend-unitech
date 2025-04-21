<?php

namespace App\Imports;

use App\Models\Product;
use Illuminate\Support\Str;
use App\Models\ProductImage;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class ProductsImport implements ToModel, WithHeadingRow
{
    /**
     * @param array $row
     *
     * @return \Illuminate\Database\Eloquent\Model|null
     */
    public function model(array $row)
    {

        $product = Product::create([
            'product_name' => $row['product_name'],
            'description' => $row['description'],
            'category' => 4,
            'gender' => $this->getGender($row['gender']),
            'rim_type' => 4,
            'style' => 4,
            'material' => 5,
            'shape' => 4,
            'eye_size' => $row['eye_size'],
            'manufacturer_name' => 3,
            'price' => $this->getSalePrice($row['price']),
            'purchase_price' => $this->getPurchasePrice($row['purchase_price']),
            'available_quantity' => $this->availabelQuantity($row['available_quantity']),
            'product_status' => $this->getProductStatus($row['product_status']),
            'vto' => $row['vto'],
            'glasses_type' => $row['glasses_type'],
            'lens_size' => $row['lens_size'],
            'temple_size' => $row['temple_size'],
            'bridge_size' => $row['bridge_size'],
            'photo_config_name' => $row['photo_config_name'],
        ]);


        \App\Models\ProductColor::create([
            'product_id' => $product->product_id,
            'color_id' => 4,
        ]);

        \App\Models\ProductFrameSize::create([
            'product_id' => $product->product_id,
            'frame_size_id' => 4,
        ]);


        if (isset($row['images']) && !empty($row['images'])) {
            $images = explode(',', $row['images']);
            foreach ($images as $image) {
                $image = trim($image);
                if (!empty($image)) {
                    ProductImage::create([
                        'product_id' => $product->product_id,
                        'image_path' => $image,
                    ]);
                }
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
        DB::table('company_product_mapper')->insert($mappings);
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

    private function getPurchasePrice($price)
    {
        return is_numeric($price) ? floatval($price) : 0;
    }
    private function getSalePrice($price)
    {
        return is_numeric($price) ? floatval($price) : 0;
    }
    private function availabelQuantity($price)
    {
        return is_numeric($price) ? floatval($price) : 0;
    }




    private function getProductStatus($status)
    {
        return ($status == 1) ? 1 : 0;  // Convert product_status to 1 or 0
    }
}
