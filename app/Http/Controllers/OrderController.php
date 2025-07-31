<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Stripe\Stripe;
use Stripe\Invoice;
use App\Models\User;
use Stripe\Customer;
use App\Models\Order;
use App\Traits\Common;
use App\Models\Company;
use Stripe\InvoiceItem;
use App\Models\Employee;
use App\Mail\InoviceMail;
use App\Models\Transaction;
use App\Traits\ApiResponse;
use App\Mail\OrderMailToSeg;
use Illuminate\Http\Request;
use App\Models\ChangesPoints;
use App\Models\BillingAddress;
use App\Models\ProductVariants;
use App\Models\ShippingAddress;
use App\Models\PrecriptionDetails;
use Illuminate\Support\Facades\DB;
use App\Mail\OrderConfirmationMail;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Mail;
use App\Models\CompanyTempOrderdetail;
use App\Models\EmployeTempOrderdetail;
use Illuminate\Support\Facades\Validator;


class OrderController extends Controller
{
    //
    use ApiResponse;
    use Common;
    public function newPresOrder(Request $request)
    {
        $validator = $this->validateNewPresOrder($request);
        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        DB::beginTransaction();

        try {
            $user = auth('sanctum')->user();
            $employeeId = $user->employee_id;
            $companyId = $user->company_id;

            // ✅ Store prescription and order
            $pres = $this->storePrescriptionDetails($request, $user);
            $order = $this->storeOrderDetails($request, $user, $pres->id);
            $this->storeAddressDetails($request, $order->id);


            // ✅ Handle payment methods
            if ($request->payment_method === 'Online Payment') {
                $this->handleOnlinePayment($request, $order, $employeeId);
            } elseif ($request->payment_method === 'Benefit Amount + Online Payment') {
                $this->handleBenefitAndOnlinePayment($request, $order, $user);
            } elseif ($request->payment_method === 'Free Order') {
                $this->handleFreeOrder($request, $order, $user);
            } else {
                $this->handleBenefitOnlyPayment($request, $order, $user);
            }

            // ✅ Send order-related emails
            $this->sendOrderMails($order, $request);

            DB::commit();

            return response()->json([
                'status' => true,
                'message' => 'Order and prescription details saved successfully.',
                'order_confire' => $order->order_confirmation_number,
                'order_id' => $order->id,
                'prescription_id' => $pres->id,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error saving order and prescription: ' . $e->getMessage());

            return response()->json([
                'status' => false,
                'message' => 'Something went wrong while processing the order.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function existingPresOrder(Request $request)
    {
        $validator = $this->validateExistingPresOrder($request);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        DB::beginTransaction();

        try {
            $user = auth('sanctum')->user();
            $employeeId = $user->employee_id;
            $companyId = $user->company_id;

            $order = $this->storeExistingOrder($request);
            $this->storeAddressDetails($request, $order->id);

            if ($request->payment_method === 'Online Payment') {
                $this->handleOnlinePayment($request, $order, $employeeId);
            } elseif ($request->payment_method === 'Benefit Amount + Online Payment') {
                $this->handleBenefitPlusOnlinePayment($request, $order, $employeeId);
            } elseif ($request->payment_method === 'Free Order') {
                $this->handleFreeOrder($request, $order, $user);
            } else {
                $this->handleBenefitOnlyPaymentOfExsisting($request, $order, $employeeId);
            }

            $this->sendOrderMails($order, $request);

            $latestPrescription = PrecriptionDetails::where('employee_id', $employeeId)->latest()->first();

            DB::commit(); // Commit transaction if all is well

            return response()->json([
                'status' => true,
                'message' => 'Order placed using existing prescription.',
                'order_confire' => $order->order_confirmation_number,
                'order_id' => $order->id,
                'prescription_id' => $latestPrescription->id,
            ]);
        } catch (\Exception $e) {
            DB::rollBack(); // Rollback transaction on any exception

            // Optionally log the error
            Log::error('Error in existingPresOrder: ' . $e->getMessage(), ['stack' => $e->getTraceAsString()]);

            return response()->json([
                'status' => false,
                'message' => 'Something went wrong while placing the order.',
                'error' => $e->getMessage()
            ], 500);
        }
    }





    public function postpdonline(Request $request)
    {
        try {
            $employeeId = auth('sanctum')->user()->employee_id;

            // Validate input
            $request->validate([
                'pupil_distance_online' => 'required|numeric',
                'od_left_2_pds_online' => 'nullable|numeric',
                'od_right_2_pds_online' => 'nullable|numeric',
            ]);


            $latestPrescription = PrecriptionDetails::where('employee_id', $employeeId)->latest()->first();

            $data = [
                'pupil_distance_online' => $request->pupil_distance_online,
                'od_left_2_pds_online' => $request->od_left_2_pds_online,
                'od_right_2_pds_online' => $request->od_right_2_pds_online,
            ];

            if ($latestPrescription) {
                $latestPrescription->update($data);
            } else {
                $data['employee_id'] = $employeeId;
                PrecriptionDetails::create($data);
            }

            return $this->successResponse(null, 'PD data saved successfully', []);
        } catch (\Exception $e) {
            return $this->errorResponse(null, $e->getMessage(), [], 500);
        }
    }

    public function companylist(Request $request)
    {

        $companies = Company::select('id', 'company_Information')->get();

        return $this->successResponse(['model' => 'company'], 'Companies Details successfully', [
            'companies' => $companies,
        ]);
    }




    //function for deleting employe tem order details 
    public function deleteEmployeeOrderDetails($employeeId)
    {


        $orderDetails = EmployeTempOrderdetail::where('employee_id', $employeeId)->first();

        if (!$orderDetails) {
            return;
        }

        if ($orderDetails->prescription_image && file_exists(public_path($orderDetails->prescription_image))) {
            unlink(public_path($orderDetails->prescription_image));
        } else {
        }

        if ($orderDetails->frame_picture && file_exists(public_path($orderDetails->frame_picture))) {
            unlink(public_path($orderDetails->frame_picture));
        } else {
        }

        $orderDetails->delete();
    }
    // function deleting company temp order details
    public function deleteCompanyOrderDetails($companyId)
    {
        $orderDetails = CompanyTempOrderdetail::where('company_id', $companyId)->first();

        if (!$orderDetails) {
            return;
        }

        if ($orderDetails->prescription_image && file_exists(public_path($orderDetails->prescription_image))) {
            unlink(public_path($orderDetails->prescription_image));
        }

        if ($orderDetails->frame_picture && file_exists(public_path($orderDetails->frame_picture))) {
            unlink(public_path($orderDetails->frame_picture));
        }

        $orderDetails->delete();
    }
    //function for uploading images 
    private function uploadImages($image, $directory = 'products')
    {
        $destinationPath = public_path("projectimages/{$directory}");

        if (!file_exists($destinationPath)) {
            mkdir($destinationPath, 0777, true);
        }

        $originalName = $image->getClientOriginalName();
        $fileName = time() . '_' . preg_replace('/\s+/', '_', $originalName);

        $image->move($destinationPath, $fileName);

        if (file_exists("$destinationPath/$fileName")) {
            return "/projectimages/{$directory}/{$fileName}";
        } else {
            dd("Image move failed: $fileName");
        }
    }
    // only getting order for employee
    public function getEmployeeOrders(Request $request)
    {
        $baseUrl = env('BASE_URL');
        $EmplyeeId = auth('sanctum')->user()->employee_id;

        $orders = Order::where('employee_id', $EmplyeeId)
            ->with([
                'employee_data:employee_id,name as employee_name,email',
                'company_data:company_id,email',

                'companysubadmin:id,name as subadmin_name,email',
                'company:id,company_name',
                'orderPoints:order_id,point',
                'prescription',
                'shipping_address',
                'billing_address',
                'blue_light_protection:id,title',
                'lense_material:id,title',
                'scratch_coating:id,title',
                'lens_tint:id,title',
                'lens_protection:id,title',
                'frame_size:frame_size_id,frame_size_name',
                'product:product_id,product_name,sku,manufacturer_name', // add manufacturer_name if needed
                'product.manufacturer:manufacturer_id,manufacturer_name', // nested relation to get manufacturer
                'variant',
            ])->get();


        $orders = $orders->map(function ($order) {
            $order->order_points = $order->orderPoints->pluck('point')->toArray(); // convert to array of strings
            unset($order->orderPoints); // remove original relation if needed
            unset($order->product->manufacturer_name); // remove original relation if needed
            if ($order->company) {
                $order->company_data->company_name = $order->company->company_name;
            }
            unset($order->company); // remove original relation if needed
            return $order;
        });



        return response()->json([
            'status' => true,
            'message' => 'Orders fetched successfully',
            'data' => $orders
        ]);
    }
    //getting order of company and company subadmin
    public function getCompanyOrders(Request $request)
    {
        $baseUrl = env('BASE_URL'); // Assuming this is your media URL for images
        $CompanyId = auth('sanctum')->user()->company_id;

        $orders = Order::where('company_id', $CompanyId)
            ->with([
                'employee_data:employee_id,name as employee_name,email',
                'company_data:company_id,email',
                'companysubadmin:id,name as subadmin_name,email',
                'company:id,company_name',
                'orderPoints:order_id,point',
                'prescription',
                'shipping_address',
                'billing_address',
                'blue_light_protection:id,title',
                'lense_material:id,title',
                'scratch_coating:id,title',
                'lens_tint:id,title',
                'lens_protection:id,title',
                'frame_size:frame_size_id,frame_size_name',
                'product:product_id,product_name,sku,manufacturer_name', // add manufacturer_name if needed
                'product.manufacturer:manufacturer_id,manufacturer_name', // nested relation to get manufacturer
                'variant',
            ])->get();


        $orders = $orders->map(function ($order) {
            $order->order_points = $order->orderPoints->pluck('point')->toArray(); // convert to array of strings
            unset($order->orderPoints); // remove original relation if needed
            unset($order->product->manufacturer_name); // remove original relation if needed
            // Add subadmin_id inside companysubadmin object safely
            if ($order->companysubadmin) {
                $order->companysubadmin->subadmin_id = $order->companysubadmin->id;
            }
            if ($order->company) {
                $order->company_data->company_name = $order->company->company_name;
            }
            unset($order->company); // remove original relation if needed
            return $order;
        });
        return response()->json([
            'status' => true,
            'message' => 'Orders fetched successfully',
            'data' => $orders
        ]);
    }
    // getting all order for owner and seg_admin
    public function getAllOrders(Request $request)
    {
        $baseUrl = env('BASE_URL');

        $orders = Order::with([
            'employee_data:employee_id,name as employee_name,email',
            'company_data:company_id,email',
            'companysubadmin:id,name as subadmin_name,email',
            'company:id,company_name',
            'orderPoints:order_id,point',
            'prescription',
            'shipping_address',
            'billing_address',
            'blue_light_protection:id,title',
            'lense_material:id,title',
            'scratch_coating:id,title',
            'lens_tint:id,title',
            'lens_protection:id,title',
            'frame_size:frame_size_id,frame_size_name',
            'product:product_id,product_name,sku,manufacturer_name', // add manufacturer_name if needed
            'product.manufacturer:manufacturer_id,manufacturer_name', // nested relation to get manufacturer
            'variant'
        ])->get();


        $orders = $orders->map(function ($order) {
            $order->order_points = $order->orderPoints->pluck('point')->toArray(); // convert to array of strings
            unset($order->orderPoints); // remove original relation if needed
            unset($order->product->manufacturer_name); // remove original relation if needed
            if ($order->companysubadmin) {
                $order->companysubadmin->subadmin_id = $order->companysubadmin->id;
            }
            if ($order->company) {
                $order->company_data->company_name = $order->company->company_name;
            }
            unset($order->company); // remove original relation if needed
            return $order;
        });
        return response()->json([
            'status' => true,
            'message' => 'Orders fetched successfully',
            'data' => $orders
        ]);
    }
    //owner is updateing the status of owner 
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
    //also her owner is updating status
    public function updateOrder(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'blue_light_protection' => 'nullable|string',
            'order_type' => 'nullable|string|max:255',

            'lense_material' => 'nullable|string|max:255',
            'scratch_coating' => 'nullable',
            'lens_tint' => 'nullable|string|max:255',
            'lens_protection' => 'nullable|string|max:255',
            // Billing details
            'billing_first_name' => 'nullable|string|max:255',
            'billing_last_name' => 'nullable|string|max:255',
            'billing_email' => 'nullable|email|max:255',
            'billing_country' => 'nullable|string|max:255',
            'billing_city' => 'nullable|string|max:255',
            'billing_state' => 'nullable|string|max:255',
            'billing_address' => 'nullable|string|max:1000',
            'billing_second_address' => 'nullable|string|max:1000',
            'billing_zip_postal_code' => 'nullable|string|max:20',
            'billing_phone_number' => 'nullable|string|max:20',
            'order_status' => 'nullable|',
            'shipping_status' => 'nullable|string|max:100',
            // Shipping details
            'shipping_first_name' => 'nullable|string|max:255',
            'shipping_last_name' => 'nullable|string|max:255',
            'shipping_email' => 'nullable|email|max:255',
            'shipping_country' => 'nullable|string|max:255',
            'shipping_city' => 'nullable|string|max:255',
            'shipping_state' => 'nullable|string|max:255',
            'shipping_address' => 'nullable|string|max:1000',
            'shipping_second_address' => 'nullable|string|max:1000',
            'shipping_zip_postal_code' => 'nullable|string|max:20',
            'shipping_phone_number' => 'nullable|string|max:20',
            'shipping_additional_information' => 'nullable|string|max:255',
            'payment_method' => 'nullable|string|max:100',
            'product_id' => 'nullable|integer',
            'color' => 'nullable|integer',
            'frame_size' => 'nullable',
            'product_quantity' => 'nullable|integer|min:1',
            'net_total' => 'nullable|numeric|min:0',
            'paid_amount_via_benefit ' => 'nullable|numeric|min:0',
            'paid_amount_via_card ' => 'nullable|numeric|min:0',

            // Prescription fields
            'frame_type' => 'nullable|string|max:255',
            'frame_prescription' => 'nullable|string|max:255',
            'prescription_image' => 'nullable|image|max:2048',
            'od_left_sphere' => 'nullable|string|max:10',
            'od_left_cylinders' => 'nullable|string|max:10',
            'od_left_axis' => 'nullable|string|max:10',
            'od_left_nv_add' => 'nullable|string|max:10',
            'od_left_2_pds' => 'nullable|string|max:10',
            'od_right_sphere' => 'nullable|string|max:10',
            'od_right_cylinders' => 'nullable|string|max:10',
            'od_right_axis' => 'nullable|string|max:10',
            'od_right_nv_add' => 'nullable|string|max:10',
            'od_right_2_pds' => 'nullable|string|max:10',
            'pupil_distance' => 'nullable|string',
            'frame_picture' => 'nullable|image|max:2048',
            'pupil_distance_online' => 'nullable|string',
            'od_left_2_pds_online' => 'nullable|string|max:10',
            'od_right_2_pds_online' => 'nullable|string|max:10',
            'update_points' => 'nullable|array',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $employeeId = auth('sanctum')->user()->employee_id;
        $companyId = auth('sanctum')->user()->company_id;

        // Find existing order
        $order = Order::findOrFail($id);



        // Update prescription details
        $pres = PrecriptionDetails::findOrFail($order->prescription_id);
        foreach (
            $request->only([
                'frame_type',
                'frame_prescription',
                'od_left_sphere',
                'od_left_cylinders',
                'od_left_axis',
                'od_left_nv_add',
                'od_left_2_pds',
                'od_right_sphere',
                'od_right_cylinders',
                'od_right_axis',
                'od_right_nv_add',
                'od_right_2_pds',
                'pupil_distance',
                'pupil_distance_online',
                'od_left_2_pds_online',
                'od_right_2_pds_online',
            ]) as $key => $value
        ) {
            $pres->$key = $value;
        }

        if ($request->hasFile('prescription_image')) {
            $pres->prescription_image = $this->uploadImages($request->file('prescription_image'), 'prescriptions');
        }
        if ($request->hasFile('frame_picture')) {
            $pres->frame_picture = $this->uploadImages($request->file('frame_picture'), 'frames');
        }
        $pres->save();


        foreach (
            $request->only([
                'blue_light_protection',
                'order_type',
                'lense_material',
                'scratch_coating',
                'lens_tint',
                'lens_protection',
                'payment_method',
                'product_id',
                'product_quantity',
                'net_total',
                'paid_amount_via_benefit',
                'paid_amount_via_card',

                'frame_size',
                'color',
                'order_status',
                'shipping_status'
            ]) as $key => $value
        ) {
            $order->$key = $value;
        }

        $order->save();

        // ✅ Update only provided fields in Shipping Address
        $shipping = ShippingAddress::where('order_id', $order->id)->firstOrFail();
        foreach (
            $request->only([
                'shipping_first_name',
                'shipping_last_name',
                'shipping_email',
                'shipping_country',
                'shipping_state',
                'shipping_city',
                'shipping_address',
                'shipping_second_address',
                'shipping_zip_postal_code',
                'shipping_phone_number',
                'shipping_additional_information'
            ]) as $key => $value
        ) {
            $field = str_replace('shipping_', '', $key);
            $shipping->$field = $value;
        }
        $shipping->save();

        // ✅ Update only provided fields in Billing Address
        $billing = BillingAddress::where('order_id', $order->id)->firstOrFail();
        foreach (
            $request->only([
                'billing_first_name',
                'billing_last_name',
                'billing_email',
                'billing_country',
                'billing_state',
                'billing_city',
                'billing_address',
                'billing_second_address',
                'billing_zip_postal_code',
                'billing_phone_number'
            ]) as $key => $value
        ) {
            $field = str_replace('billing_', '', $key);
            $billing->$field = $value;
        }
        $billing->save();

        if ($request->has('update_points') && is_array($request->update_points)) {
            // Purane points delete karo
            ChangesPoints::where('order_id', $order->id)->delete();

            // Naye points tabhi insert karo jab valid value ho
            foreach ($request->update_points as $point) {
                if (!is_null($point)) { // null check
                    ChangesPoints::create([
                        'order_id' => $order->id,
                        'point' => $point
                    ]);
                }
            }
        }


        // ✅ Benefit deduction
        if ($request->has('net_total')) {
            $employee = Employee::findOrFail($employeeId);
            $newDeductionAmount = $request->net_total;

            $employee->benefit_amount += $order->net_total;
            $deductionAmount = min($newDeductionAmount, $employee->benefit_amount);
            $employee->benefit_amount -= $deductionAmount;
            $employee->save();

            Transaction::create([
                'employee_id' => $employeeId,
                'transaction_type' => 'debit',
                'amount' => $newDeductionAmount,
                'balance' => $employee->benefit_amount,
                'description' => 'order update',
            ]);
        }


        // Send email notification
        $user = User::where('role', 'employee')->where('employee_id', $employeeId)->first();
        if ($user) {
            // Mail::to($user->email)->send(new OrderConfirmationMail($order));
        }

        return response()->json([
            'status' => true,
            'message' => 'Order updated successfully.',
            'order_id' => $order->id,
            'prescription_id' => $pres->id,
        ]);
    }
    // update tray id and time
    public function update_tray_id(Request $request, $id)
    {
        try {
            // Validate request
            $validated = $request->validate([
                'tray_id' => 'required|string',
                'time' => 'required|string',
            ]);

            // Find and update order
            $order = Order::findOrFail($id);
            $order->tray_id = $validated['tray_id'] ?? null;
            $order->time = $validated['time'] ?? null;
            $order->order_status = 'Pending';
            $order->save();

            return $this->successResponse(
                ['model' => 'order'],
                'Tray ID and time updated successfully. Order status set to Pending.',
                $order,
                200
            );
        } catch (\Illuminate\Validation\ValidationException $e) {
            return $this->errorResponse(
                ['model' => 'order'],
                $e->getMessage(),
                null,
                422
            );
        } catch (\Exception $e) {
            return $this->errorResponse(
                ['model' => 'order'],
                'Something went wrong while updating the order.',
                ['error' => $e->getMessage()],
                500
            );
        }
    }


    //validaion for new prescription oreder 
    private function validateNewPresOrder(Request $request)
    {
        return Validator::make($request->all(), [
            'blue_light_protection' => 'nullable|string',
            'order_type' => 'nullable|string|max:255',
            'lense_material' => 'nullable|string|max:255',
            'scratch_coating' => 'nullable',
            'lens_tint' => 'nullable|string|max:255',
            'lens_protection' => 'nullable|string|max:255',
            // Billing details
            'billing_first_name' => 'required|string|max:255',
            'billing_last_name' => 'required|string|max:255',
            'billing_email' => 'required|email|max:255',
            'billing_country' => 'required|string|max:255',
            'billing_city' => 'required|string|max:255',
            'billing_state' => 'required|string|max:255',
            'billing_address' => 'required|string|max:1000',
            'billing_second_address' => 'nullable|string|max:1000',
            'billing_zip_postal_code' => 'required|string|max:20',
            'billing_phone_number' => 'required|string|max:20',
            // Shipping details
            'shipping_first_name' => 'required|string|max:255',
            'shipping_last_name' => 'required|string|max:255',
            'shipping_email' => 'required|email|max:255',
            'shipping_country' => 'required|string|max:255',
            'shipping_city' => 'required|string|max:255',
            'shipping_state' => 'required|string|max:255',
            'shipping_address' => 'required|string|max:1000',
            'shipping_second_address' => 'nullable|string|max:1000',
            'shipping_zip_postal_code' => 'required|string|max:20',
            'shipping_phone_number' => 'required|string|max:20',
            'shipping_additional_information' => 'nullable|string|max:255',
            'payment_method' => 'required|string|max:100',
            'shipping_status' => 'required|string|max:100',

            'product_id' => 'required|integer',
            'variant_id' => 'required|integer',
            'frame_size' => 'required',
            'product_quantity' => 'required|integer|min:1',
            'net_total' => 'required|numeric|min:0',
            'paid_amount_via_benefit' => 'nullable|numeric|min:0',
            'paid_amount_via_card' => 'nullable|numeric|min:0',
            // Prescription fields
            'frame_type' => 'required|string|max:255',
            'frame_prescription' => 'required|string|max:255',
            'prescription_image' => 'nullable|image|max:2048',
            'od_left_sphere' => 'nullable|string|max:10',
            'od_left_cylinders' => 'nullable|string|max:10',
            'od_left_axis' => 'nullable|string|max:10',
            'od_left_nv_add' => 'nullable|string|max:10',
            'od_left_2_pds' => 'nullable|string|max:10',
            'od_right_sphere' => 'nullable|string|max:10',
            'od_right_cylinders' => 'nullable|string|max:10',
            'od_right_axis' => 'nullable|string|max:10',
            'od_right_nv_add' => 'nullable|string|max:10',
            'od_right_2_pds' => 'nullable|string|max:10',
            'pupil_distance' => 'nullable|string',
            'frame_picture' => 'nullable|image|max:2048',
            'pupil_distance_online' => 'nullable|string',
            'od_left_2_pds_online' => 'nullable|string|max:10',
            'od_right_2_pds_online' => 'nullable|string|max:10',
            'vertical_right' => 'nullable|string',
            'vertical_left' => 'nullable|string',
            'vertical_base_direction_right' => 'nullable|string',
            'vertical_base_direction_left' => 'nullable|string',
            'horizontal_rigth' => 'nullable|string',
            'horizontal_left' => 'nullable|string',
            'horizontal_base_direction_right' => 'nullable|string',
            'horizontal_base_direction_left' => 'nullable|string',
            'special_notes' => 'nullable|string',
        ]);
    }

    // saving prescription details of new order
    private function storePrescriptionDetails(Request $request, $user)
    {
        $pres = new PrecriptionDetails();

        if ($user->role === 'employee') {
            $pres->employee_id = $user->employee_id;
        } elseif (in_array($user->role, ['company', 'company_subadmin'])) {
            $pres->company_id = $user->company_id;
        }

        $pres->fill($request->only([
            'frame_type',
            'frame_prescription',
            'od_left_sphere',
            'od_left_cylinders',
            'od_left_axis',
            'od_left_nv_add',
            'od_left_2_pds',
            'od_right_sphere',
            'od_right_cylinders',
            'od_right_axis',
            'od_right_nv_add',
            'od_right_2_pds',
            'pupil_distance',
            'pupil_distance_online',
            'od_left_2_pds_online',
            'od_right_2_pds_online',
            'vertical_right',
            'vertical_left',
            'vertical_base_direction_right',
            'vertical_base_direction_left',
            'horizontal_rigth',
            'horizontal_left',
            'horizontal_base_direction_right',
            'horizontal_base_direction_left',
            'special_notes',
        ]));

        if ($request->hasFile('prescription_image')) {
            $pres->prescription_image = $this->uploadImages($request->file('prescription_image'), 'prescriptions');
        }

        if ($request->hasFile('frame_picture')) {
            $pres->frame_picture = $this->uploadImages($request->file('frame_picture'), 'frames');
        }

        $pres->save();

        return $pres;
    }
    //save order details or new order 
    private function storeOrderDetails(Request $request, $user, $prescriptionId)
    {
        $order = new Order();

        if ($user->role === 'employee') {
            $order->employee_id = $user->employee_id;
            $order->company_id = $user->company_id;
            $order->order_by = 'employee';
        } elseif ($user->role === 'company') {
            $order->company_id = $user->company_id;
            $order->employee_id = null;
            $order->order_by = 'company';
        } elseif ($user->role === 'company_subadmin') {
            $order->company_id = $user->company_id;
            $order->employee_id = null;
            $order->order_by = 'company_subadmin';
            $order->subadmin_id = $user->id;
        }

        $order->fill($request->only([
            'blue_light_protection',
            'order_type',
            'lense_material',
            'scratch_coating',
            'lens_tint',
            'lens_protection',
            'payment_method',
            'shipping_status',
            'product_id',
            'product_quantity',
            'net_total',
            'paid_amount_via_card',
            'paid_amount_via_benefit',
            'frame_size',
            'variant_id'
        ]));

        $paymentMethod = $request->payment_method;

        if (in_array($paymentMethod, ['Online Payment', 'Benefit Amount + Online Payment'])) {
            $order->payment_status = 'Unpaid';
        } else {
            $order->payment_status = 'Paid';
        }

        $order->order_status = 'Pending';
        $order->prescription_id = $prescriptionId;

        // Custom order confirmation number
        $lastOrder = Order::whereNotNull('order_confirmation_number')
            ->orderBy('order_confirmation_number', 'desc')
            ->first();

        $order->order_confirmation_number = $lastOrder
            ? $lastOrder->order_confirmation_number + 1
            : 100021;

        $order->save();

        return $order;
    }
    //store the address details or order 
    private function storeAddressDetails(Request $request, $orderId)
    {
        // Shipping Address
        $shipping = new ShippingAddress();
        $shipping->fill([
            'first_name' => $request->input('shipping_first_name'),
            'last_name' => $request->input('shipping_last_name'),
            'email' => $request->input('shipping_email'),
            'country' => $request->input('shipping_country'),
            'state' => $request->input('shipping_state'),
            'city' => $request->input('shipping_city'),
            'address' => $request->input('shipping_address'),
            'second_address' => $request->input('shipping_second_address'),
            'zip_postal_code' => $request->input('shipping_zip_postal_code'),
            'phone_number' => $request->input('shipping_phone_number'),
            'additional_information' => $request->input('shipping_additional_information'),
        ]);
        $shipping->order_id = $orderId;
        $shipping->save();

        // Billing Address
        $billing = new BillingAddress();
        $billing->fill([
            'first_name' => $request->input('billing_first_name'),
            'last_name' => $request->input('billing_last_name'),
            'email' => $request->input('billing_email'),
            'country' => $request->input('billing_country'),
            'state' => $request->input('billing_state'),
            'city' => $request->input('billing_city'),
            'address' => $request->input('billing_address'),
            'second_address' => $request->input('billing_second_address'),
            'zip_postal_code' => $request->input('billing_zip_postal_code'),
            'phone_number' => $request->input('billing_phone_number'),
        ]);
        $billing->order_id = $orderId;
        $billing->save();
    }
    // store payment details 
    private function handleOnlinePayment($request, $order, $employeeId)
    {
        try {
            Stripe::setApiKey(config('services.stripe.secret'));

            if ($request->net_total <= 0) {
                throw new \Exception("Invoice amount must be greater than $0.00");
            }

            $customer = Customer::create([
                'email' => $request->billing_email,
                'name'  => "{$request->billing_first_name} {$request->billing_last_name}",
                'phone' => $request->billing_phone_number,
                'address' => [
                    'line1' => $request->billing_address,
                    'line2' => $request->billing_second_address ?? '',
                    'city' => $request->billing_city,
                    'state' => $request->billing_state,
                    'country' => $request->billing_country,
                    'postal_code' => $request->billing_zip_postal_code,
                ],
            ]);

            $invoice = Invoice::create([
                'customer' => $customer->id,
                'collection_method' => 'send_invoice',
                'days_until_due' => 30,
                'auto_advance' => false, // Disable automatic email sending
                'description' => 'Order #' . $order->id,
            ]);

            InvoiceItem::create([
                'customer' => $customer->id,
                'amount' => $request->net_total * 100,
                'currency' => 'usd',
                'description' => 'Order Payment',
                'invoice' => $invoice->id,
            ]);
            $finalInvoice = Invoice::retrieve($invoice->id)->finalizeInvoice();

            $order->update([
                'stripe_invoice_id' => $finalInvoice->id,
                'stripe_invoice_url' => $finalInvoice->hosted_invoice_url,
            ]);

            $this->deleteEmployeeOrderDetails($employeeId);
        } catch (\Exception $e) {
            Log::error('Stripe Invoice Error: ' . $e->getMessage());
            throw new \Exception('Failed to create Stripe invoice.');
        }
    }
    //handale benefit and online 
    private function handleBenefitAndOnlinePayment($request, $order, $user)
    {
        try {
            $remainingAmount = $request->net_total;

            if ($user->role === 'employee') {
                $employee = Employee::findOrFail($user->employee_id);
                $deductionAmount = min($employee->benefit_amount, $remainingAmount);
                if ($deductionAmount > 0) {
                    $employee->benefit_amount -= $deductionAmount;
                    $employee->save();
                    Transaction::create([
                        'employee_id' => $employee->id,
                        'transaction_type' => 'debit',
                        'amount' => $deductionAmount,
                        'balance' => $employee->benefit_amount,
                        'description' => 'Order payment from benefit',
                    ]);
                    $this->deleteEmployeeOrderDetails($employee->id);
                    $remainingAmount -= $deductionAmount;
                }
            } elseif (in_array($user->role, ['company', 'company_subadmin'])) {
                $company = Company::findOrFail($user->company_id);
                $deductionAmount = min($company->benefit_amount, $remainingAmount);
                if ($deductionAmount > 0) {
                    $company->benefit_amount -= $deductionAmount;
                    $company->save();

                    $transactionData = [
                        'company_id' => $company->id,
                        'transaction_type' => 'debit',
                        'amount' => $deductionAmount,
                        'balance' => $company->benefit_amount,
                        'description' => 'order place on belhaf of benefits amount and pay later',
                    ];
                    if ($user->role === 'company_subadmin') {
                        $transactionData['subadmin_id'] = $user->id;
                    }

                    Transaction::create($transactionData);
                    $this->deleteCompanyOrderDetails($company->id);
                    $remainingAmount -= $deductionAmount;
                }
            }

            if ($remainingAmount > 0) {
                $this->createStripeInvoice($request, $order, $remainingAmount, true);
            }
        } catch (\Exception $e) {
            Log::error('Benefit + Online Payment Error: ' . $e->getMessage());
            throw new \Exception('Failed to process partial benefit payment.');
        }
    }
    private function handleBenefitOnlyPayment($request, $order, $user)
    {
        try {
            $deductionAmount = $request->net_total;

            if ($user->role === 'employee') {
                $employee = Employee::findOrFail($user->employee_id);

                // Step 1: Deduct the order amount
                $paymentAmount = min($employee->benefit_amount, $deductionAmount);
                $employee->benefit_amount -= $paymentAmount;
                $employee->save();

                $this->deleteEmployeeOrderDetails($employee->id);

                // Step 2: Save the actual order payment transaction
                Transaction::create([
                    'employee_id' => $employee->id,
                    'transaction_type' => 'debit',
                    'amount' => $paymentAmount,
                    'balance' => $employee->benefit_amount,
                    'description' => 'Order payment from benefit',
                ]);

                // Step 3: Trash the remaining amount (if any)
                if ($employee->benefit_amount > 0) {
                    $trashedAmount = $employee->benefit_amount;
                    $employee->benefit_amount = 0;
                    $employee->save();

                    Transaction::create([
                        'employee_id' => $employee->id,
                        'transaction_type' => 'debit',
                        'amount' => $trashedAmount,
                        'balance' => 0,
                        'description' => 'Remaining benefit amount has been trashed',
                    ]);
                }
            } elseif (in_array($user->role, ['company', 'company_subadmin'])) {
                $company = Company::findOrFail($user->company_id);

                // Step 1: Deduct the order amount
                $paymentAmount = min($company->benefit_amount, $deductionAmount);
                $company->benefit_amount -= $paymentAmount;
                $company->save();

                $this->deleteCompanyOrderDetails($company->id);

                // Step 2: Save the actual order payment transaction
                $transaction = [
                    'company_id' => $company->id,
                    'transaction_type' => 'debit',
                    'amount' => $paymentAmount,
                    'balance' => $company->benefit_amount,
                    'description' => $user->role === 'company_subadmin'
                        ? 'Order payment by subadmin from company balance'
                        : 'Order payment from company balance',
                ];

                if ($user->role === 'company_subadmin') {
                    $transaction['subadmin_id'] = $user->id;
                }

                Transaction::create($transaction);

                // Step 3: Trash the remaining amount (if any)
                if ($company->benefit_amount > 0) {
                    $trashedAmount = $company->benefit_amount;
                    $company->benefit_amount = 0;
                    $company->save();

                    $trashTransaction = [
                        'company_id' => $company->id,
                        'transaction_type' => 'debit',
                        'amount' => $trashedAmount,
                        'balance' => 0,
                        'description' => 'Remaining benefit amount has been trashed',
                    ];

                    if ($user->role === 'company_subadmin') {
                        $trashTransaction['subadmin_id'] = $user->id;
                    }

                    Transaction::create($trashTransaction);
                }
            }
        } catch (\Exception $e) {
            Log::error('Benefit Payment Error: ' . $e->getMessage());
            throw new \Exception('Failed to process benefit payment.');
        }
    }


    private function handleFreeOrder($request, $order, $user)
    {
        try {
            if ($user->role === 'employee') {
                $employee = Employee::findOrFail($user->employee_id);

                // ✅ Reduce free order limit if it's above 0
                if ($employee->free_order_limit > 0) {
                    $employee->free_order_limit -= 1;
                }

                $employee->save();

                // ✅ Clean up any related employee order details
                $this->deleteEmployeeOrderDetails($employee->id);
            } elseif (in_array($user->role, ['company', 'company_subadmin'])) {
                $company = Company::findOrFail($user->company_id);

                // ✅ Reduce company's free order limit if it's above 0
                if ($company->free_order_limit > 0) {
                    $company->free_order_limit -= 1;
                }

                $company->save();

                // ✅ Clean up any related company order details
                $this->deleteCompanyOrderDetails($company->id);
            }
        } catch (\Exception $e) {
            Log::error('Free Order Handling Error: ' . $e->getMessage());
            throw new \Exception('Failed to process free order.');
        }
    }



    private function createStripeInvoice($request, $order, $amount, $isPartial = false)
    {
        Stripe::setApiKey(config('services.stripe.secret'));

        $customer = Customer::create([
            'email' => $request->billing_email,
            'name'  => "{$request->billing_first_name} {$request->billing_last_name}",
            'phone' => $request->billing_phone_number,
            'address' => [
                'line1' => $request->billing_address,
                'line2' => $request->billing_second_address ?? '',
                'city' => $request->billing_city,
                'state' => $request->billing_state,
                'country' => $request->billing_country,
                'postal_code' => $request->billing_zip_postal_code,
            ],
        ]);
        $invoice = Invoice::create([
            'customer' => $customer->id,
            'collection_method' => 'send_invoice',
            'days_until_due' => 30,
            'auto_advance' => false,
            'description' => 'Order #' . $order->id . ($isPartial ? ' (Partial Benefit Payment)' : ''),
        ]);

        InvoiceItem::create([
            'customer' => $customer->id,
            'amount' => $amount * 100,
            'currency' => 'usd',
            'description' => $isPartial ? 'Remaining Order Payment' : 'Order Payment',
            'invoice' => $invoice->id,
        ]);

        $finalInvoice = Invoice::retrieve($invoice->id)->finalizeInvoice();

        $order->update([
            'stripe_invoice_id' => $finalInvoice->id,
            'stripe_invoice_url' => $finalInvoice->hosted_invoice_url,
        ]);
    }

    private function sendOrderMails($order, $request)
    {
        try {
            $user = auth('sanctum')->user();
            $role = $user->role;
            $email = null;

            if ($role === 'employee') {
                $employeeUser = User::where('role', 'employee')
                    ->where('employee_id', $user->employee_id)
                    ->first();

                $email = $employeeUser?->email;

                $companyUser = User::where('role', 'company')
                    ->where('company_id', $employeeUser->company_id)
                    ->first();

                if ($companyUser) {
                    Mail::to($companyUser->email)->send(new OrderConfirmationMail($order));
                }
            } elseif ($role === 'company') {
                $companyUser = User::where('role', 'company')
                    ->where('company_id', $user->company_id)
                    ->first();

                $email = $companyUser?->email;
            } elseif ($role === 'company_subadmin') {
                $subadminUser = User::where('role', 'company_subadmin')
                    ->where('id', $user->id)
                    ->first();

                $email = $subadminUser?->email;

                $companyUser = User::where('role', 'company')
                    ->where('company_id', $subadminUser->company_id)
                    ->first();

                if ($companyUser) {
                    Mail::to($companyUser->email)->send(new OrderConfirmationMail($order));
                }
            }

            // 📨 Send to the authenticated user
            if ($email) {
                Mail::to($email)->send(new OrderConfirmationMail($order));
            }

            $superAdmin = User::find(1);
            if ($superAdmin) {
                Mail::to($superAdmin->email)->send(new OrderMailToSeg($order->id));
            }

            Mail::to($request->billing_email)->send(new InoviceMail($order->id));
        } catch (\Exception $e) {
            Log::error("Failed to send mail for Order ID: {$order->id}. Error: " . $e->getMessage());
        }
    }


    // exsisting prescription 
    private function validateExistingPresOrder(Request $request)
    {
        return Validator::make($request->all(), [
            'blue_light_protection' => 'nullable|string',
            'order_type' => 'nullable|string|max:255',
            'lense_material' => 'nullable|string|max:255',
            'scratch_coating' => 'nullable',
            'lens_tint' => 'nullable|string|max:255',
            'lens_protection' => 'nullable|string|max:255',

            'payment_method' => 'required|string|max:100',
            'shipping_status' => 'required|string|max:100',

            'product_id' => 'required|integer',
            'variant_id' => 'required|integer',
            'frame_size' => 'required',

            'product_quantity' => 'required|integer|min:1',
            'net_total' => 'required|numeric|min:0',
            'paid_amount_via_benefit' => 'nullable|numeric|min:0',
            'paid_amount_via_card' => 'nullable|numeric|min:0',

            // Billing details
            'billing_first_name' => 'required|string|max:255',
            'billing_last_name' => 'required|string|max:255',
            'billing_email' => 'required|email|max:255',
            'billing_country' => 'required|string|max:255',
            'billing_city' => 'required|string|max:255',
            'billing_state' => 'required|string|max:255',
            'billing_address' => 'required|string|max:1000',
            'billing_second_address' => 'nullable|string|max:1000',
            'billing_zip_postal_code' => 'required|string|max:20',
            'billing_phone_number' => 'required|string|max:20',

            // Shipping details
            'shipping_first_name' => 'required|string|max:255',
            'shipping_last_name' => 'required|string|max:255',
            'shipping_email' => 'required|email|max:255',
            'shipping_country' => 'required|string|max:255',
            'shipping_city' => 'required|string|max:255',
            'shipping_state' => 'required|string|max:255',
            'shipping_address' => 'required|string|max:1000',
            'shipping_second_address' => 'nullable|string|max:1000',
            'shipping_zip_postal_code' => 'required|string|max:20',
            'shipping_phone_number' => 'required|string|max:20',
            'shipping_additional_information' => 'nullable|string|max:255',
        ]);
    }


    private function storeExistingOrder(Request $request)
    {


        $employeeId = auth('sanctum')->user()->employee_id;
        $companyId = auth('sanctum')->user()->company_id;
        $user = auth('sanctum')->user();

        $latestPrescription = PrecriptionDetails::where('employee_id', $employeeId)->latest()->first();

        if (!$latestPrescription) {
            return response()->json([
                'status' => false,
                'message' => 'No prescription found for this employee.'
            ], 404);
        }

        $order = new Order();

        $order->employee_id = $employeeId;
        $order->company_id = $companyId;
        $order->order_by = 'employee'; // 👈 Set by employee

        $order->fill($request->only([
            'blue_light_protection',
            'order_type',
            'lense_material',
            'scratch_coating',
            'lens_tint',
            'lens_protection',
            'payment_method',
            'shipping_status',
            'product_id',
            'product_quantity',
            'net_total',
            'paid_amount_via_card',
            'paid_amount_via_benefit',
            'frame_size',
            'variant_id'
        ]));

        // Payment status logic
        $paymentMethod = $request->payment_method;
        $order->payment_status = in_array($paymentMethod, ['Online Payment', 'Benefit Amount + Online Payment'])
            ? 'Unpaid'
            : 'Paid';

        $order->order_status = 'Pending';
        $order->prescription_id = $latestPrescription?->id;

        // Custom confirmation number generation
        $lastOrder = Order::whereNotNull('order_confirmation_number')
            ->orderBy('order_confirmation_number', 'desc')
            ->first();

        $order->order_confirmation_number = $lastOrder
            ? $lastOrder->order_confirmation_number + 1
            : 100021;

        $order->save();

        return $order;
    }

    private function handleBenefitPlusOnlinePayment(Request $request, $order, $employeeId)
    {
        try {
            $employee = Employee::findOrFail($employeeId);
            $remainingAmount = $request->net_total;
            $deductionAmount = min($employee->benefit_amount, $remainingAmount);

            // Deduct from employee benefit
            if ($deductionAmount > 0) {
                $employee->benefit_amount -= $deductionAmount;
                $employee->save();

                Transaction::create([
                    'employee_id' => $employeeId,
                    'transaction_type' => 'debit',
                    'amount' => $deductionAmount,
                    'balance' => $employee->benefit_amount,
                    'description' => 'Order payment from benefit',
                ]);

                $this->deleteEmployeeOrderDetails($employeeId);

                $remainingAmount -= $deductionAmount;
            }

            // Process remaining via Stripe
            if ($remainingAmount > 0) {
                try {
                    Stripe::setApiKey(config('services.stripe.secret'));

                    $customer = Customer::create([
                        'email' => $request->billing_email,
                        'name'  => "{$request->billing_first_name} {$request->billing_last_name}",
                        'phone' => $request->billing_phone_number,
                        'address' => [
                            'line1' => $request->billing_address,
                            'line2' => $request->billing_second_address ?? '',
                            'city' => $request->billing_city,
                            'state' => $request->billing_state,
                            'country' => $request->billing_country,
                            'postal_code' => $request->billing_zip_postal_code,
                        ],
                    ]);

                    $invoice = Invoice::create([
                        'customer' => $customer->id,
                        'collection_method' => 'send_invoice',
                        'days_until_due' => 30,
                        'auto_advance' => false,
                        'description' => 'Order #' . $order->id . ' (Partial Benefit Payment)',
                    ]);

                    InvoiceItem::create([
                        'customer' => $customer->id,
                        'amount' => $remainingAmount * 100, // cents
                        'currency' => 'usd',
                        'description' => 'Remaining Order Payment',
                        'invoice' => $invoice->id,
                    ]);

                    $finalInvoice = Invoice::retrieve($invoice->id)->finalizeInvoice();

                    $order->update([
                        'stripe_invoice_id' => $finalInvoice->id,
                        'stripe_invoice_url' => $finalInvoice->hosted_invoice_url,
                    ]);
                } catch (\Exception $e) {
                    Log::error('Stripe Partial Invoice Error: ' . $e->getMessage());
                }
            }
        } catch (\Exception $e) {
            Log::error('Payment Error: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to process payment.'], 500);
        }
    }

    private function handleBenefitOnlyPaymentOfExsisting(Request $request, $order, $employeeId)
    {
        try {
            $employee = Employee::findOrFail($employeeId);
            $deductionAmount = $request->net_total;

            if ($employee->benefit_amount < $deductionAmount) {
                $deductionAmount = $employee->benefit_amount;
            }

            // Step 1: Deduct the order amount
            $employee->benefit_amount -= $deductionAmount;
            $employee->save();

            $this->deleteEmployeeOrderDetails($employeeId);

            // Step 2: Save the actual order payment transaction
            Transaction::create([
                'employee_id' => $employeeId,
                'transaction_type' => 'debit',
                'amount' => $deductionAmount,
                'balance' => $employee->benefit_amount,
                'description' => 'Order payment from benefit',
            ]);

            // Step 3: Trash the remaining benefit amount if any
            if ($employee->benefit_amount > 0) {
                $trashedAmount = $employee->benefit_amount;
                $employee->benefit_amount = 0;
                $employee->save();

                Transaction::create([
                    'employee_id' => $employeeId,
                    'transaction_type' => 'debit',
                    'amount' => $trashedAmount,
                    'balance' => 0,
                    'description' => 'Remaining benefit amount has been trashed',
                ]);
            }
        } catch (\Exception $e) {
            Log::error('Benefit Payment Error: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to process benefit payment.'], 500);
        }
    }
}
