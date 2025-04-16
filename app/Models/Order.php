<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    //
    
    protected $table = 'orders'; 

    protected $guarded = [];


    public function employee_data(){
        return $this->belongsTo(User::class,'employee_id','employee_id');
    
    }

    public function company_data(){
        return $this->belongsTo(User::class, 'company_id','company_id')->where('role','company');

    }
    
    public function orderPoints()
    {
        return $this->hasMany(ChangesPoints::class, 'order_id');
    }


public function prescription(){
    return $this->belongsTo(PrecriptionDetails::class,'prescription_id');
    
}

public function shipping_address(){
    return $this->belongsTo(ShippingAddress::class,'id','order_id');
    
}
public function billing_address(){
    return $this->belongsTo(BillingAddress::class,'id','order_id');
    
}


}
