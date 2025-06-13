<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\LensManegment\LensMaterial;
use App\Models\LensManegment\BlueLightProtection;
use App\Models\LensManegment\LensProtection;
use App\Models\LensManegment\LensTint;
use App\Models\LensManegment\ScracthCoating;

class Order extends Model
{
    //

    protected $table = 'orders';

    protected $guarded = [];


    public function employee_data()
    {
        return $this->belongsTo(User::class, 'employee_id', 'employee_id');
    }

    public function company_data()
    {
        return $this->belongsTo(User::class, 'company_id', 'company_id')->where('role', 'company');
    }

    public function orderPoints()
    {
        return $this->hasMany(ChangesPoints::class, 'order_id');
    }

    public function prescription()
    {
        return $this->belongsTo(PrecriptionDetails::class, 'prescription_id');
    }

    public function shipping_address()
    {
        return $this->belongsTo(ShippingAddress::class, 'id', 'order_id');
    }
    public function billing_address()
    {
        return $this->belongsTo(BillingAddress::class, 'id', 'order_id');
    }


    public function blue_light_protection(){
        return $this->hasOne(BlueLightProtection::class,'id','blue_light_protection');   
    }
    public function lense_material(){
        return $this->hasOne(LensMaterial::class,'id','lense_material');   
    }

    public function scratch_coating(){
        return $this->hasOne(ScracthCoating::class,'id','scratch_coating');   

    }

    public function lens_tint(){
        return $this->hasOne(LensTint::class,'id','lens_tint');   
    }
    public function lens_protection(){
        return $this->hasOne(LensProtection::class,'id','lens_protection');   
    }

    public function color(){
        return $this->hasOne(Color::class,'color_id','color');  
    }

    public function frame_size(){
        return $this->hasOne(FrameSize::class,'frame_size_id','frame_size');  
    }

    public function product(){
        return $this->hasOne(Product::class,'product_id','product_id')->with('manufacturer');  

    }
     public function variant()
    {
        return $this->hasOne(ProductVariants::class, 'id', 'variant_id')->with('variant_images');
    }


}
