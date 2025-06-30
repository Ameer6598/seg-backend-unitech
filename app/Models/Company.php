<?php

namespace App\Models;

use App\Models\LensManegment\LensTint;
use Illuminate\Database\Eloquent\Model;
use App\Models\LensManegment\LensMaterial;
use App\Models\LensManegment\LensProtection;
use App\Models\LensManegment\ScracthCoating;
use App\Models\LensManegment\BlueLightProtection;

class Company extends Model
{
    //
    protected $table = 'companies';

    protected $guarded = [];

    public function user()
    {
        return $this->belongsTo(User::class, 'id', 'company_id')->where('role',);
    }

    public function users()
    {
        return $this->hasMany(User::class, 'company_id', 'id')->where('role', 'company');
    }


    public function products()
    {
        return $this->hasManyThrough(Product::class, CompanyProduct::class, 'company_id', 'product_id', 'id', 'product_id')->select('products.product_id', 'products.product_name');
    }

    public function lensmaterial()
    {
        return $this->hasManyThrough(LensMaterial::class, CompanyLensMaterial::class, 'company_id', 'id', 'id', 'lens_material_id')->select('lens_material.id', 'lens_material.title');
    }

    public function scratchcoatings()
    {
        return $this->hasManyThrough(ScracthCoating::class, CompanyScratchCoatings::class, 'company_id', 'id', 'id', 'scratch_coating_id')->select('scracth_coating.id', 'scracth_coating.title');
    }


    public function lenstint()
    {
        return $this->hasManyThrough(LensTint::class, Companylenstint::class, 'company_id', 'id', 'id', 'lens_tint_id')->select('lens_tint.id', 'lens_tint.title');
    }

    public function lensprotection()
    {
        return $this->hasManyThrough(LensProtection::class, CompanyLensProtection::class, 'company_id', 'id', 'id', 'lens_protection_id')->select('lens_protection.id', 'lens_protection.title');
    }

    public function bluelightprotection()
    {

        return $this->hasManyThrough(BlueLightProtection::class, CompanyBlueLightProtection::class, 'company_id', 'id', 'id', 'blue_light_protection_id')->select('blue_light_protection.id', 'blue_light_protection.title');
    }

    public function lenstypesubcategories()
    {
        return $this->hasManyThrough(LensTypeSubcategories::class, CompanyLensTypeSubcategories::class, 'company_id', 'id', 'id', 'sub_cate_id')->select('lens_type_subcategories.id', 'lens_type_subcategories.title');
    }

}
