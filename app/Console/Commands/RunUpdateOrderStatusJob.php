<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Order;
use Stripe\Stripe;
use Stripe\Invoice;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;

class RunUpdateOrderStatusJob extends Command
{
    protected $signature = 'job:update-order-status';
    protected $description = 'Check Stripe invoices and update order payment status if paid';

    public function handle()
    {
        $this->info('Checking Stripe invoices for orders...');

        try {
            Stripe::setApiKey(config('services.stripe.secret'));

            $orders = Order::whereIn('payment_method', ['Online Payment', 'Benefit Amount + Online Payment'])
                ->whereNotNull('stripe_invoice_id')
                ->where('payment_status', '!=', 'Paid')
                ->get();

            $updatedCount = 0;

            foreach ($orders as $order) {
                try {
                    $invoice = Invoice::retrieve($order->stripe_invoice_id);

                    if ($invoice->status === 'paid') {
                        $order->payment_status = 'Paid';
                        
                        $order->save();

                        $this->info("Order #{$order->id} marked as Paid.");
                        $updatedCount++;
                    }
                } catch (\Exception $e) {
                    Log::error("Stripe Invoice Error for Order ID {$order->id}: " . $e->getMessage());
                    $this->error("Error checking Order #{$order->id}. See logs for details.");
                }
            }

            $this->info("Payment status updated for {$updatedCount} orders.");
        } catch (\Exception $e) {
            Log::error('Stripe Job Execution Error: ' . $e->getMessage());
            $this->error('Something went wrong while updating order statuses.');
        }
    }
}
