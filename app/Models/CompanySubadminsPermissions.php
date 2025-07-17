<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CompanySubadminsPermissions extends Model
{
    protected $table = 'company_subadmin_permissions';
    protected $guarded = [];

    // Boolean accessors for permissions
    protected $appends = [
        'frame_read',
        'frame_assign',
        'assigned_lenses_read',
        'orders_list_read',
        'new_order_create',
        'employee_create',
        'employee_read',
        'employee_update',
        'employee_delete',
        'employee_impersinate',

        'assign_benefits_to_employee',
    ];

    public function getFrameReadAttribute($value)
    {
        return (bool) $this->attributes['frame_read'];
    }

    public function getFrameAssignAttribute($value)
    {
        return (bool) $this->attributes['frame_assign'];
    }

    public function getAssignedLensesReadAttribute($value)
    {
        return (bool) $this->attributes['assigned_lenses_read'];
    }

    public function getOrdersListReadAttribute($value)
    {
        return (bool) $this->attributes['orders_list_read'];
    }

    public function getNewOrderCreateAttribute($value)
    {
        return (bool) $this->attributes['new_order_create'];
    }

    public function getEmployeeCreateAttribute($value)
    {
        return (bool) $this->attributes['employee_create'];
    }

    public function getEmployeeReadAttribute($value)
    {
        return (bool) $this->attributes['employee_read'];
    }

    public function getEmployeeUpdateAttribute($value)
    {
        return (bool) $this->attributes['employee_update'];
    }

    public function getEmployeeDeleteAttribute($value)
    {
        return (bool) $this->attributes['employee_delete'];
    }

  public function getEmployeeImpersinateAttribute($value)
    {
        return (bool) $this->attributes['employee_impersinate'];
    }

        public function getAssignBenefitsToEmployeeAttribute($value)
    {
        return (bool) $this->attributes['assign_benefits_to_employee'];
    }
}
