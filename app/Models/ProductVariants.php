<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductVariants extends Model
{

    protected $table = 'product_variants';
    protected $guarded = [];

    public function variant_images()
    {
        return $this->hasMany(ProductImage::class, 'variant_id','id');
    }
}
