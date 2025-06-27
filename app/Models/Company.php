<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

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
        return $this->hasManyThrough( Product::class,CompanyProduct::class,'company_id','product_id','id','product_id')->select('products.product_id', 'products.product_name');
    }
}
