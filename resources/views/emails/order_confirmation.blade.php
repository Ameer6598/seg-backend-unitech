<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation - Your Safety Eyewear is Being Processed at Safety Eye Guard!</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }
        p {
            margin-bottom: 15px;
            text-align: left;
        }
        strong {
            font-weight: bold;
        }
        a {
            color: #0066cc;
            text-decoration: none;
        }
        hr {
            border: 0;
            height: 1px;
            background-color: #ddd;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <p>Hello,</p>
    
    <p>Thank you for placing your order with Safety Eye Guard. We're excited to help you protect your vision with safety eyewear you can trust.</p>
    
    <p>We've received your order and it is now being processed.</p>
    
    <p><strong>Order Summary:</strong></p>
    
    <p><strong>Product:</strong> {{ $order->product->product_name }} - (Lens Type, Coatings, Treatments)</p>
    
    <p><strong>Order ID:</strong> {{ $order->order_confirmation_number }}</p>
    
    <p><strong>Order Date:</strong> {{ $order->created_at->toDateString() }}</p>
    
    <p>You'll receive a notification with tracking details as soon as your order has been shipped.</p>
    
    <p>In the meantime, you can check your order status anytime by logging into your company's Safety Eye Guard account.</p>
    
    <p>If you have any questions or need assistance, we're here to help every step of the way. Feel free to reach out to us at <a href="mailto:service@safetyeyeguard.com">service@safetyeyeguard.com</a> or call <a href="tel:8443005773">844-300-5773</a>.</p>
    
    <p>Thank you once again for choosing Safety Eye Guard. We're proud to support your workplace safety and are committed to delivering eyewear that fits your needs, comfortably, reliably, and on time.</p>
    
    <p>Stay safe,<br>
    The Safety Eye Guard Team</p>
    
    <hr>
    
    <p style="text-align: center;">If you have any questions, reply to this email or contact our support team.</p>
</body>
</html>