<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model

{
    //
    protected $table = 'products';

    protected $guarded = [];

    protected $primaryKey = 'product_id';

    public function images()
    {
        return $this->hasMany(ProductImage::class, 'product_id', 'product_id');
    }

    public function productcategory()
    {
        return $this->hasOne(Category::class, 'category_id', 'category');
    }

    public function productcolor()
    {
        return $this->hasOne(Color::class, 'color_id', 'color');
    }
    public function framezie()
    {
        return $this->hasOne(FrameSize::class, 'frame_size_id', 'frame_sizes');
    }
    public function rimtype()
    {
        return $this->hasOne(RimType::class, 'rim_type_id', 'rim_type');
    }
    public function material()
    {
        return $this->belongsTo(Material::class, 'material');
    }
    
    public function shape()
    {
        return $this->belongsTo(Shape::class, 'shape');
    }
    
    public function manufacturer()
    {
        return $this->hasOne(Manufacturer::class, 'manufacturer_id', 'manufacturer_name');
    }
}
