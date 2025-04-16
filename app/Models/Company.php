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
        return $this->belongsTo(User::class,'id', 'company_id')->where('role',);
    }
    


}
 