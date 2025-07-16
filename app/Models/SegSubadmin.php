<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SegSubadmin extends Model
{
    protected $table = 'seg_subadmin';
    protected $guarded = [];

    public function user()
    {
        return $this->belongsTo(User::class, 'id', 'seg_subadmin_id')->where('role', 'seg_subadmin');
    }

    public function permissions()
    {
        return $this->hasOne(SubadminPermissions::class, 'subadmin_id', 'id');
    }
}
