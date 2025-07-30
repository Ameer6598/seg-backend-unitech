<?php

namespace App\Mail;

use App\Models\Order;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Queue\SerializesModels;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Contracts\Queue\ShouldQueue;

use Illuminate\Support\Facades\Log; // Add this at the top if not already

class OrderConfirmationMail extends Mailable
{
    use Queueable, SerializesModels;

    public $order;
    /**
     * Create a new message instance.
     */
    public function __construct(Order $order)
    {

        $this->order = Order::where('id', $order->id)
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
            subject: 'Order Confirmation - Your Safety Eyewear is Being Processed at Safety Eye Guard!',
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.order_confirmation', // Ensure this view exists
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
