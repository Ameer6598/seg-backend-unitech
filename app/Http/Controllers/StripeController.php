<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Stripe\Checkout\Session;

use Stripe\Stripe;



class StripeController extends Controller
{

    public function createCheckoutSession(Request $request)
    {
        Stripe::setApiKey(config('services.stripe.secret'));
        $request->validate([
            'amount' => 'required|numeric|min:1',
        ]);
        try {
            $session = Session::create([
                'payment_method_types' => ['card'],
                'line_items' => [[
                    'price_data' => [
                        'currency' => 'usd',
                        'product_data' => [
                            'name' => 'Online Purchase',
                        ],
                        'unit_amount' => $request->amount * 100,
                    ],
                    'quantity' => 1, // Always 1 because price is total
                ]],
                'mode' => 'payment',
                'success_url' => 'http://localhost:3000/confirm-order',
                'cancel_url' => 'http://localhost:3000/payment-method',
            ]);

            return response()->json([
                'checkout_url' => $session->url,
                'session_id' => $session->id
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function checkPaymentStatus(Request $request)
    {
        Stripe::setApiKey(config('services.stripe.secret'));
        $request->validate([
            'session_id' => 'required|string',
        ]);
        try {
            $session = Session::retrieve($request->session_id);
            if ($session->payment_status === 'paid') {
                return response()->json([
                    'status' => 'success',
                    'message' => 'Payment was successful.',
                ]);
            } else {
                return response()->json([
                    'status' => 'pending',
                    'message' => 'Payment not completed yet.',
                    'session' => $session,
                ]);
            }
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    



}
