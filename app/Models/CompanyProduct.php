<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CompanyProduct extends Model
{
    //
    protected $table = 'company_product_mapper';

    protected $guarded = [];

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id','id');
    }
}
