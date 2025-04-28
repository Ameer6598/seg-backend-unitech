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

    public function productsubcate()
    {
        return $this->hasOne(ProductSubcategory::class, 'id', 'sub_category');
    }



    public function colors()
    {
        return $this->belongsToMany(Color::class, 'product_colors', 'product_id', 'color_id');
    }

    public function frameSizes()
    {
        return $this->belongsToMany(FrameSize::class, 'product_frame_size', 'product_id', 'frame_size_id');
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

    public function style()
    {
        return $this->hasOne(Style::class, 'style_id', 'style');
    }
    public function manufacturer()
    {
        return $this->hasOne(Manufacturer::class, 'manufacturer_id', 'manufacturer_name');
    }
}
