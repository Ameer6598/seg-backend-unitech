<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    //
    
    protected $table = 'categories'; 

    protected $guarded = [];
    public $timestamps = false;
    protected $primaryKey = 'category_id'; 

}
