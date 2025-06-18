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
use App\Models\Transaction;
use App\Traits\ApiResponse;
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
use App\Models\EmployeTempOrderdetail;
use Illuminate\Support\Facades\Validator;


class OrderController extends Controller
{
    //
    use ApiResponse;
    use Common;
    public function newPresOrder(Request $request)
    {
        $validator = Validator::make($request->all(), [
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
            'od_left_sphere' => 'required|string|max:10',
            'od_left_cylinders' => 'required|string|max:10',
            'od_left_axis' => 'required|string|max:10',
            'od_left_nv_add' => 'required|string|max:10',
            'od_left_2_pds' => 'required|string|max:10',
            'od_right_sphere' => 'required|string|max:10',
            'od_right_cylinders' => 'required|string|max:10',
            'od_right_axis' => 'required|string|max:10',
            'od_right_nv_add' => 'required|string|max:10',
            'od_right_2_pds' => 'required|string|max:10',
            'pupil_distance' => 'required|string',
            'frame_picture' => 'nullable|image|max:2048',
            'pupil_distance_online' => 'nullable|string',
            'od_left_2_pds_online' => 'nullable|string|max:10',
            'od_right_2_pds_online' => 'nullable|string|max:10',
            'vertical_right' => 'required|string',
            'vertical_left' => 'required|string',
            'vertical_base_direction_right' => 'required|string',
            'vertical_base_direction_left' => 'required|string',
            'horizontal_rigth' => 'required|string',
            'horizontal_left' => 'required|string',
            'horizontal_base_direction_right' => 'required|string',
            'horizontal_base_direction_left' => 'required|string',
            'special_notes' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $employeeId = auth('sanctum')->user()->employee_id;
        $companyId = auth('sanctum')->user()->company_id;


        $employee = Employee::findOrFail($employeeId);

        if ($employee->ending_date && \Carbon\Carbon::now()->gt(\Carbon\Carbon::parse($employee->ending_date))) {
            return response()->json([
                'status' => false,
                'message' => 'Your benefit amount has expired.',
            ], 403);
        }

        $pres = new PrecriptionDetails();
        $pres->employee_id = $employeeId;

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

        $order = new Order();
        $order->employee_id = $employeeId;
        $order->company_id = $companyId;
        $order->fill($request->only([
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
            'paid_amount_via_card',
            'paid_amount_via_benefit',
            'frame_size',
            'variant_id'
        ]));

        // Set order status based on payment method
        $order->order_status = $request->payment_method === 'pay_later' ? 'pending_payment' : 'pending';
        $order->prescription_id = $pres->id;

        // Generate custom sequential confirmation number starting from 10001
        $lastOrder = Order::whereNotNull('order_confirmation_number')
            ->orderBy('order_confirmation_number', 'desc')
            ->first();

        if ($lastOrder) {
            $nextConfirmationNumber = $lastOrder->order_confirmation_number + 1;
        } else {
            $nextConfirmationNumber = 100021;
        }

        $order->order_confirmation_number = $nextConfirmationNumber;

        // Save order
        $order->save();


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

        $shipping->order_id = $order->id;
        $shipping->save();

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

        $billing->order_id = $order->id;
        $billing->save();
        if ($request->payment_method === 'pay_later') {
            try {
                Stripe::setApiKey(config('services.stripe.secret'));

                $remainingAmount = $request->net_total;

                if ($remainingAmount <= 0) {
                    throw new \Exception("Invoice amount must be greater than $0.00");
                }

                // Step 1: Create Stripe Customer
                $customer = Customer::create([
                    'email' => $request->billing_email,
                    'name'  => $request->billing_first_name . ' ' . $request->billing_last_name,
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

                // Step 2: Create Invoice with Payment Link
                $invoice = \Stripe\Invoice::create([
                    'customer' => $customer->id,
                    'collection_method' => 'send_invoice',
                    'days_until_due' => 30,
                    'auto_advance' => true, // Automatically finalize this invoice
                    'description' => 'Order #' . $request->order_id,
                ]);

                // Add invoice items
                \Stripe\InvoiceItem::create([
                    'customer' => $customer->id,
                    'amount' => $remainingAmount * 100, // Amount in cents
                    'currency' => 'usd',
                    'description' => 'Order Payment',
                    'invoice' => $invoice->id,
                ]);

                // Finalize and send the invoice
                $finalizedInvoice = \Stripe\Invoice::retrieve($invoice->id);
                $finalizedInvoice = $finalizedInvoice->finalizeInvoice();
                $sentInvoice = $finalizedInvoice->sendInvoice();

                $order->stripe_invoice_id = $sentInvoice->id;
                $order->stripe_invoice_url = $sentInvoice->hosted_invoice_url;
                $order->save();
            } catch (\Exception $e) {
                Log::error('Stripe Invoice Error: ' . $e->getMessage());
                return response()->json(['error' => 'Failed to create Stripe invoice.'], 500);
            }
        } else {

            $employee = Employee::findOrFail($employeeId);
            $deductionAmount = $request->net_total;

            if ($employee->benefit_amount < $deductionAmount) {
                $deductionAmount = $employee->benefit_amount;
            }
            $employee->benefit_amount -= $deductionAmount;
            $employee->save();
            $this->deleteEmployeeOrderDetails($employeeId);

            Transaction::create([
                'employee_id' => $employeeId,
                'transaction_type' => 'debit',
                'amount' => $request->net_total ?? '',
                'balance' => $employee->benefit_amount ?? '',
                'description' => 'order',
            ]);
        }

        $user = User::where('role', 'employee')->where('employee_id', $employeeId)->first();
        $email = $user->email;

        Mail::to($email)->send(new OrderConfirmationMail($order));

        return response()->json([
            'status' => true,
            'message' => 'Order and prescription details saved successfully.',
            'order_confire' => $order->order_confirmation_number,
            'order_id' => $order->id,
            'prescription_id' => $pres->id,
        ]);
    }
    public function existingPresOrder(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'blue_light_protection' => 'required|string',
            'order_type' => 'required|string|max:255',
            'lense_material' => 'required|string|max:255',
            'scratch_coating' => 'required',
            'lens_tint' => 'required|string|max:255',
            'lens_protection' => 'required|string|max:255',

            'payment_method' => 'required|string|max:100',
            'product_id' => 'required|integer',
            'variant_id' => 'required|integer ',
            'frame_size' => 'required',

            'product_quantity' => 'required|integer|min:1',
            'net_total' => 'required|numeric|min:0',
            'paid_amount_via_benefit ' => 'nullable|numeric|min:0',
            'paid_amount_via_card ' => 'nullable|numeric|min:0',


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

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $employeeId = auth('sanctum')->user()->employee_id;
        $companyId = auth('sanctum')->user()->company_id;


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

        $order->fill($request->only([
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
            'paid_amount_via_card',
            'paid_amount_via_benefit',

            'frame_size',
            'variant_id'
        ]));

        // Set order status based on payment method
        $order->order_status = $request->payment_method === 'pay_later' ? 'pending_payment' : 'pending';
        $order->prescription_id = $latestPrescription->id;

        // Generate custom sequential confirmation number starting from 10001
        $lastOrder = Order::whereNotNull('order_confirmation_number')
            ->orderBy('order_confirmation_number', 'desc')
            ->first();

        if ($lastOrder) {
            $nextConfirmationNumber = $lastOrder->order_confirmation_number + 1;
        } else {
            $nextConfirmationNumber = 100021;
        }

        $order->order_confirmation_number = $nextConfirmationNumber;

        // Save order
        $order->save();





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

        $shipping->order_id = $order->id;
        $shipping->save();


        // Save Billing Address
        $billing = new BillingAddress();
        $billing->fill([
            'first_name' => $request->input('billing_first_name'),
            'last_name' => $request->input('billing_last_name'),
            'email' => $request->input('billing_email'),
            'country' => $request->input('billing_country'),
            'state' => $request->input('billing_state'),
            'city' => $request->input('billing_city'),
            'address' => $request->input('billing_address'),
            'second_address' => $request->input('shipping_second_address'),

            'zip_postal_code' => $request->input('billing_zip_postal_code'),
            'phone_number' => $request->input('billing_phone_number'),
        ]);

        $billing->order_id = $order->id;
        $billing->save();
        if ($request->payment_method === 'pay_later') {
            try {
                Stripe::setApiKey(config('services.stripe.secret'));

                $remainingAmount = $request->net_total;

                if ($remainingAmount <= 0) {
                    throw new \Exception("Invoice amount must be greater than $0.00");
                }

                // Step 1: Create Stripe Customer
                $customer = Customer::create([
                    'email' => $request->billing_email,
                    'name'  => $request->billing_first_name . ' ' . $request->billing_last_name,
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

                // Step 2: Create Invoice with Payment Link
                $invoice = \Stripe\Invoice::create([
                    'customer' => $customer->id,
                    'collection_method' => 'send_invoice',
                    'days_until_due' => 30,
                    'auto_advance' => true, // Automatically finalize this invoice
                    'description' => 'Order #' . $request->order_id,
                ]);

                // Add invoice items
                \Stripe\InvoiceItem::create([
                    'customer' => $customer->id,
                    'amount' => $remainingAmount * 100, // Amount in cents
                    'currency' => 'usd',
                    'description' => 'Order Payment',
                    'invoice' => $invoice->id,
                ]);

                // Finalize and send the invoice
                $finalizedInvoice = \Stripe\Invoice::retrieve($invoice->id);
                $finalizedInvoice = $finalizedInvoice->finalizeInvoice();
                $sentInvoice = $finalizedInvoice->sendInvoice();

                $order->stripe_invoice_id = $sentInvoice->id;
                $order->stripe_invoice_url = $sentInvoice->hosted_invoice_url;
                $order->save();
            } catch (\Exception $e) {
                Log::error('Stripe Invoice Error: ' . $e->getMessage());
                return response()->json(['error' => 'Failed to create Stripe invoice.'], 500);
            }
        } else {
            // Employee benefit deduction for non-pay_later methods
            $employee = Employee::findOrFail($employeeId);
            $deductionAmount = $request->net_total;

            if ($employee->benefit_amount < $deductionAmount) {
                $deductionAmount = $employee->benefit_amount;
            }
            $employee->benefit_amount -= $deductionAmount;
            $employee->save();
            $this->deleteEmployeeOrderDetails($employeeId);

            Transaction::create([
                'employee_id' => $employeeId,
                'transaction_type' => 'debit',
                'amount' => $request->net_total ?? '',
                'balance' => $employee->benefit_amount ?? '',
                'description' => 'order',
            ]);
        }


        $user = User::where('role', 'employee')->where('employee_id', $employeeId)->first();


        if (!$user) {
            return response()->json([
                'status' => false,
                'message' => 'User not found.',
            ], 404);
        }

        $email = $user->email; // ye wo email ha jo mare pass GHL me contact me save ha 
        $confirmation_num = $order->order_confirmation_number;

        Mail::to($email)->send(new OrderConfirmationMail($order));

        return response()->json([
            'status' => true,
            'message' => 'Order placed using existing prescription.',
            'order_confire' => $order->order_confirmation_number,
            'order_id' => $order->id,
            'prescription_id' => $latestPrescription->id,
        ]);
    }

    public function companylist(Request $request)
    {

        $companies = Company::select('id','company_Information')->get();

        return $this->successResponse(['model' => 'company'], 'Companies Details successfully', [
            'companies' => $companies,
        ]);
    }

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
    public function getEmployeeOrders(Request $request)
    {
        $baseUrl = env('BASE_URL'); // Assuming this is your media URL for images
        $EmplyeeId = auth('sanctum')->user()->employee_id;

        $orders = Order::where('employee_id', $EmplyeeId)
            ->with([
                'employee_data:employee_id,name as employee_name,email',
                'company_data:company_id,name as company_name,email',
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

            return $order;
        });



        return response()->json([
            'status' => true,
            'message' => 'Orders fetched successfully',
            'data' => $orders
        ]);
    }
    public function getCompanyOrders(Request $request)
    {
        $baseUrl = env('BASE_URL'); // Assuming this is your media URL for images
        $CompanyId = auth('sanctum')->user()->company_id;

        $orders = Order::where('company_id', $CompanyId)
            ->with([
                'employee_data:employee_id,name as employee_name,email',
                'company_data:company_id,name as company_name,email',
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

            return $order;
        });




        return response()->json([
            'status' => true,
            'message' => 'Orders fetched successfully',
            'data' => $orders
        ]);
    }
    public function getAllOrders(Request $request)
    {
        $baseUrl = env('BASE_URL');

        $orders = Order::with([
            'employee_data:employee_id,name as employee_name,email',
            'company_data:company_id,name as company_name,email',
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


            return $order;
        });


        return response()->json([
            'status' => true,
            'message' => 'Orders fetched successfully',
            'data' => $orders
        ]);
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
            'order_status' => 'nullable|in:Pending,Confirmed,Shipped,Delivered',

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
    public function updateuuOrder(Request $request, $id)
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
                'frame_picture' => 'nullable|image|max:2048',
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

    public function getPayLaterOrders(Request $request)
    {
        try {
            // Set Stripe API key
            Stripe::setApiKey(config('services.stripe.secret'));

            // Get all orders with pay_later payment method
            $orders = Order::where('payment_method', 'pay_later')
                ->whereNotNull('stripe_invoice_id')
                ->get();

            $paidOrders = [];
            $pendingOrders = [];

            foreach ($orders as $order) {
                try {
                    // Retrieve the invoice from Stripe
                    $invoice = \Stripe\Invoice::retrieve($order->stripe_invoice_id);

                    // Check if the invoice is paid
                    if ($invoice->status === 'paid') {
                        $paidOrders[] = [
                            'order_id' => $order->id,
                            'order_confirmation_number' => $order->order_confirmation_number,
                            'employee_id' => $order->employee_id,
                            'net_total' => $order->net_total,
                            'stripe_invoice_id' => $order->stripe_invoice_id,
                            'payment_status' => 'paid',
                            'paid_at' => $invoice->status_transitions->paid_at
                                ? Carbon::createFromTimestamp($invoice->status_transitions->paid_at)->toDateTimeString()
                                : null,
                        ];
                    } else {
                        $pendingOrders[] = [
                            'order_id' => $order->id,
                            'order_confirmation_number' => $order->order_confirmation_number,
                            'employee_id' => $order->employee_id,
                            'net_total' => $order->net_total,
                            'stripe_invoice_id' => $order->stripe_invoice_id,
                            'payment_status' => $invoice->status,
                            'invoice_url' => $order->stripe_invoice_url,
                        ];
                    }
                } catch (\Exception $e) {
                    // Log any Stripe API errors for this order but continue processing others
                    Log::error('Stripe Invoice Check Error for Order #' . $order->id . ': ' . $e->getMessage());
                    // Treat as pending if we can't verify status
                    $pendingOrders[] = [
                        'order_id' => $order->id,
                        'order_confirmation_number' => $order->order_confirmation_number,
                        'employee_id' => $order->employee_id,
                        'net_total' => $order->net_total,
                        'stripe_invoice_id' => $order->stripe_invoice_id,
                        'payment_status' => 'error_checking_status',
                        'invoice_url' => $order->stripe_invoice_url,
                    ];
                }
            }

            return response()->json([
                'status' => true,
                'paid_orders' => $paidOrders,
                'pending_orders' => $pendingOrders,
            ], 200);
        } catch (\Exception $e) {
            Log::error('Get Pay Later Orders Error: ' . $e->getMessage());
            return response()->json([
                'status' => false,
                'message' => 'Failed to fetch pay later orders.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
