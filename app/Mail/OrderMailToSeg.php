<?php

namespace App\Mail;

use App\Models\Order; // Ensure you import the Order model
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log; // Add this at the top if not already


class OrderMailToSeg extends Mailable
{
    use Queueable, SerializesModels;

    public $order; // Public property to hold order data
    /**
     * Create a new message instance.
     */
    public function __construct($orderId)
    {


        $this->order = Order::where('id', $orderId)
            ->with([
                'employee_data:employee_id,name as employee_name,email',
                'company_data:company_id,name as company_name,email',
                'prescription',
                'shipping_address',
                'billing_address',
                'lens_protection_formail:id,title',
                'blue_light_protection_formail:id,title',
                'frame_size_formail',
                'product:product_id,product_name,sku,manufacturer_name,featured_image',
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
            subject: 'New order received',
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {

        return new Content(
            view: 'emails.OrderMailToSeg', // Replace with your actual Blade view name (e.g., resources/views/emails/invoice.blade.php)
            with: [
                'order' => $this->order, // Pass the order data to the view
            ]
        );
    }

    /**
     * Get the attachments for the message.
     *
     * @return array<int, \Illuminate\Mail\Mailables\Attachment>
     */
    public function attachments(): array
    {
        return [];
    }
}
