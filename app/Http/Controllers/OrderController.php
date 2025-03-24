<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Traits\Common;
use App\Models\Employee;
use App\Models\Transaction;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use App\Models\ChangesPoints;
use Illuminate\Support\Facades\DB;

class OrderController extends Controller
{
    //
    use ApiResponse;
    use Common;


    public function storeOrder(Request $request)
    {
        try {
            $request->validate([
                'order_type' => 'required|string',
                'frame_type' => 'required|string',
                'frame_prescription' => 'required|string',
                'frame_prescription_type' => 'required|string',
                'prescription_image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
                'lense_sizes' => 'required|string',
                'od_left_sphere' => 'nullable|string',
                'blue_light_protection' => 'nullable|string',
                'od_left_cylinders' => 'nullable|string',
                'od_left_axis' => 'nullable|string',
                'od_left_nv_add' => 'nullable|string',
                'od_left_2_pds' => 'nullable|string',
                'od_right_sphere' => 'nullable|string',
                'od_right_cylinders' => 'nullable|string',
                'od_right_axis' => 'nullable|string',
                'od_right_nv_add' => 'nullable|string',
                'od_right_2_pds' => 'nullable|string',
                'lense_use' => 'required|string',
                'frame_picture' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
                'product_details' => 'required|string',
                'lense_material' => 'required|string',
                'scratch_coating' => 'required|string',
                'lens_tint' => 'required|string',
                'lens_protection' => 'required|string',
                'first_name' => 'required|string',
                'last_name' => 'required|string',
                'email' => 'required|email',
                'country' => 'required|string',
                'city' => 'required|string',
                'address' => 'required|string',
                'zip_postal_code' => 'required|string',
                'phone_number' => 'required|string',
                'payment_method' => 'required|string',
                'order_confirmation_number' => 'required|string|unique:orders',
                'product_id' => 'required|integer',
                'product_quantity' => 'required|integer',
                'net_total' => 'required|integer',
            ]);

            $employee = Employee::where('id', auth('sanctum')->user()->employee_id)->first();
            if (!$employee || $request->net_total > $employee->benefit_amount) {
                return $this->errorResponse(['model' => 'orders'], 'Net total exceeds the employee benefit amount.', [], 422);
            }
            DB::beginTransaction();

            // Prescription Image
            $prescriptionImage = null;
            if ($request->hasFile('prescription_image')) {
                $file = $request->file('prescription_image');
                $originalName = $file->getClientOriginalName();
                $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
                $destinationPath = public_path('projectimages/orders/prescriptions');
                if (!file_exists($destinationPath)) {
                    mkdir($destinationPath, 0777, true);
                }
                $file->move($destinationPath, $fileName);
                $prescriptionImage = '/projectimages/orders/prescriptions/' . $fileName;
            }

            // Frame Picture
            $framePicture = null;
            if ($request->hasFile('frame_picture')) {
                $file = $request->file('frame_picture');
                $originalName = $file->getClientOriginalName();
                $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
                $destinationPath = public_path('projectimages/orders/frames');
                if (!file_exists($destinationPath)) {
                    mkdir($destinationPath, 0777, true);
                }
                $file->move($destinationPath, $fileName);
                $framePicture = '/projectimages/orders/frames/' . $fileName;
            }

            $order = Order::create([
                'order_type' => $request->order_type,
                'frame_type' => $request->frame_type,
                'frame_prescription' => $request->frame_prescription,
                'frame_prescription_type' => $request->frame_prescription_type,
                'blue_light_protection' => $request->blue_light_protection,
                'prescription_image' => $prescriptionImage,
                'lense_sizes' => $request->lense_sizes,
                'od_left_sphere' => $request->od_left_sphere,
                'od_left_cylinders' => $request->od_left_cylinders,
                'od_left_axis' => $request->od_left_axis,
                'od_left_nv_add' => $request->od_left_nv_add,
                'od_left_2_pds' => $request->od_left_2_pds,
                'od_right_sphere' => $request->od_right_sphere,
                'od_right_cylinders' => $request->od_right_cylinders,
                'od_right_axis' => $request->od_right_axis,
                'od_right_nv_add' => $request->od_right_nv_add,
                'od_right_2_pds' => $request->od_right_2_pds,
                'lense_use' => $request->lense_use,
                'frame_picture' => $framePicture,
                'product_details' => $request->product_details,
                'lense_material' => $request->lense_material,
                'scratch_coating' => $request->scratch_coating,
                'lens_tint' => $request->lens_tint,
                'lens_protection' => $request->lens_protection,
                'first_name' => $request->first_name,
                'last_name' => $request->last_name,
                'email' => $request->email,
                'country' => $request->country,
                'city' => $request->city,
                'address' => $request->address,
                'zip_postal_code' => $request->zip_postal_code,
                'phone_number' => $request->phone_number,
                'payment_method' => $request->payment_method,
                'order_confirmation_number' => $request->order_confirmation_number,
                'product_id' => $request->product_id,
                'product_quantity' => $request->product_quantity,
                'order_status' => 'Pending',
                'net_total' => $request->net_total,
                'employee_id' => auth('sanctum')->user()->employee_id,
                'company_id' => auth('sanctum')->user()->company_id,
            ]);
            $employee = Employee::findOrFail(auth('sanctum')->user()->employee_id);
            $employee->benefit_amount -= $request->net_total;
            $employee->save();
            $transaction = Transaction::create([
                'employee_id' => auth('sanctum')->user()->employee_id,
                'transaction_type' => 'debit',
                'amount' => $request->net_total ?? '',
                'balance' => $employee->benefit_amount ?? '',
                'description' => 'order',
            ]);
            DB::commit();
            return $this->successResponse(array('model' => 'orders'), 'Order created successfully', [
                'order' => $order,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return $this->errorResponse(['model' => 'orders'], $e->getMessage(), [], 422);
        }
    }

    public function getEmployeeOrders(Request $request)
    {
        try {

            $orders = $this->getOrders($request, 'employee');

            return $this->successResponse(array('model' => 'orders'), 'Order fetch successfully', [
                'orders' => $orders,
            ]);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'orders'], $e->getMessage(), [], 422);
        }
    }

    public function getCompanyOrders(Request $request)
    {
        try {

            $orders = $this->getOrders($request, 'company');

            return $this->successResponse(array('model' => 'orders'), 'Order fetch successfully', [
                'orders' => $orders,
            ]);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'orders'], $e->getMessage(), [], 422);
        }
    }

    public function getAllOrders(Request $request)
    {
        try {

            $orders = $this->getOrders($request, '');

            return $this->successResponse(array('model' => 'orders'), 'Order fetch successfully', [
                'orders' => $orders,
            ]);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'orders'], $e->getMessage(), [], 422);
        }
    }

    public function updateOrderStatus(Request $request)
    {
        try {

            $request->validate([
                'order_id' => 'required',
                'order_status' => 'required',
            ]);

            DB::beginTransaction();
            $order = Order::findOrFail($request->order_id);
            $order->order_status = $request->order_status;
            $order->update();

            DB::commit();

            return $this->successResponse(['model' => 'company'], 'Order status updated successfully', []);
        } catch (\Exception $e) {
            return $this->errorResponse(['model' => 'orders'], $e->getMessage(), [], 422);
        }
    }


    public function updateOrder(Request $request, $id)
{
    try {
        $request->validate([
            'order_type' => 'nullable|string',
            'frame_type' => 'nullable|string',
            'frame_prescription' => 'nullable|string',
            'blue_light_protection' => 'nullable|string',
            'frame_prescription_type' => 'nullable|string',
            'prescription_image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
            'lense_sizes' => 'nullable|string',
            'od_left_sphere' => 'nullable|string',
            'od_left_cylinders' => 'nullable|string',
            'od_left_axis' => 'nullable|string',
            'od_left_nv_add' => 'nullable|string',
            'od_left_2_pds' => 'nullable|string',
            'od_right_sphere' => 'nullable|string',
            'od_right_cylinders' => 'nullable|string',
            'od_right_axis' => 'nullable|string',
            'od_right_nv_add' => 'nullable|string',
            'od_right_2_pds' => 'nullable|string',
            'lense_use' => 'nullable|string',
            'frame_picture' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
            'product_details' => 'nullable|string',
            'lense_material' => 'nullable|string',
            'scratch_coating' => 'nullable|string',
            'lens_tint' => 'nullable|string',
            'lens_protection' => 'nullable|string',
            'order_status' => 'nullable|string',
            'update_points' => 'nullable|array'
        ]);

        $order = Order::findOrFail($id);

        // Handle prescription image
        $prescriptionImage = $order->prescription_image;
        if ($request->hasFile('prescription_image')) {
            $oldPrescriptionPath = public_path($order->prescription_image);
            if ($order->prescription_image && file_exists($oldPrescriptionPath)) {
                unlink($oldPrescriptionPath);
            }

            $file = $request->file('prescription_image');
            $originalName = $file->getClientOriginalName();
            $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
            $destinationPath = public_path('projectimages/orders/prescriptions');

            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }
            $file->move($destinationPath, $fileName);
            $prescriptionImage = '/projectimages/orders/prescriptions/' . $fileName;
        }

        // Handle frame picture
        $framePicture = $order->frame_picture;
        if ($request->hasFile('frame_picture')) {
            $oldFramePath = public_path($order->frame_picture);
            if ($order->frame_picture && file_exists($oldFramePath)) {
                unlink($oldFramePath);
            }
            $file = $request->file('frame_picture');
            $originalName = $file->getClientOriginalName();
            $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);
            $destinationPath = public_path('projectimages/orders/frames');
            if (!file_exists($destinationPath)) {
                mkdir($destinationPath, 0777, true);
            }
            $file->move($destinationPath, $fileName);
            $framePicture = '/projectimages/orders/frames/' . $fileName;
        }

        // Update order fields only if present in request
        $order->update([
            'order_type' => $request->input('order_type', $order->order_type),
            'frame_type' => $request->input('frame_type', $order->frame_type),
            'frame_prescription' => $request->input('frame_prescription', $order->frame_prescription),
            'blue_light_protection' => $request->input('blue_light_protection', $order->blue_light_protection),
            'frame_prescription_type' => $request->input('frame_prescription_type', $order->frame_prescription_type),
            'prescription_image' => $prescriptionImage,
            'lense_sizes' => $request->input('lense_sizes', $order->lense_sizes),
            'od_left_sphere' => $request->input('od_left_sphere', $order->od_left_sphere),
            'od_left_cylinders' => $request->input('od_left_cylinders', $order->od_left_cylinders),
            'od_left_axis' => $request->input('od_left_axis', $order->od_left_axis),
            'od_left_nv_add' => $request->input('od_left_nv_add', $order->od_left_nv_add),
            'od_left_2_pds' => $request->input('od_left_2_pds', $order->od_left_2_pds),
            'od_right_sphere' => $request->input('od_right_sphere', $order->od_right_sphere),
            'od_right_cylinders' => $request->input('od_right_cylinders', $order->od_right_cylinders),
            'od_right_axis' => $request->input('od_right_axis', $order->od_right_axis),
            'od_right_nv_add' => $request->input('od_right_nv_add', $order->od_right_nv_add),
            'od_right_2_pds' => $request->input('od_right_2_pds', $order->od_right_2_pds),
            'lense_use' => $request->input('lense_use', $order->lense_use),
            'frame_picture' => $framePicture,
            'product_details' => $request->input('product_details', $order->product_details),
            'lense_material' => $request->input('lense_material', $order->lense_material),
            'scratch_coating' => $request->input('scratch_coating', $order->scratch_coating),
            'lens_tint' => $request->input('lens_tint', $order->lens_tint),
            'lens_protection' => $request->input('lens_protection', $order->lens_protection),
            'order_status' => $request->input('order_status', $order->order_status),
        ]);

        if ($request->has('update_points') && is_array($request->update_points)) {
            foreach ($request->update_points as $point) {
                ChangesPoints::create([
                    'order_id' => $order->id,
                    'point' => $point
                ]);
            }
        }

        return $this->successResponse(['model' => 'orders'], 'Order updated successfully', [
            'order' => $order,
        ]);
    } catch (\Exception $e) {
        return $this->errorResponse(['model' => 'orders'], $e->getMessage(), [], 422);
    }
}

}
