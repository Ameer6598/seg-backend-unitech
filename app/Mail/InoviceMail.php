<?php

namespace App\Mail;

use App\Models\Order; // Ensure you import the Order model
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class InoviceMail extends Mailable
{
    use Queueable, SerializesModels;

    public $order; // Public property to hold order data

    /**
     * Create a new message instance.
     */
    public function __construct($orderId)
    {
        // Fetch the order with related data using the provided order_id
        $this->order = Order::where('id', $orderId)
            ->with([
                'employee_data:employee_id,name as employee_name,email',
                'company_data:company_id,name as company_name,email',
                'prescription',
                'shipping_address',
                'billing_address',
                'product:product_id,product_name,sku,manufacturer_name',
                'product.manufacturer:manufacturer_id,manufacturer_name',
                'variant',
            ])
            ->firstOrFail(); // Use firstOrFail to ensure the order exists
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Invoice Mail',
            to: $this->order->billing_address->email // Set the recipient to billing address email
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.invoice', // Replace with your actual Blade view name (e.g., resources/views/emails/invoice.blade.php)
            with: [
                'order' => $this->order, // Pass the order data to the view
            ]
        );
    }

    /**
     * Get the attachments for the message.
     */
    public function attachments(): array
    {
        return []; // Add attachments if needed
    }
}