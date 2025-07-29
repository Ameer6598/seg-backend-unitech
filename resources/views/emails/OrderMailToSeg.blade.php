<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>New Order Notification - Safety Eye Guard</title>
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
    <p>Hello Admin,</p>
    
    <p>A new order has been placed through the Safety Eye Guard platform. Please find the order details below:</p>
    
    <p><strong>Product:</strong> {{ $order->product->product_name }}</p>
    
    <p><strong>Order ID:</strong> {{ $order->order_confirmation_number }}</p>
    
    <p><strong>Order Date:</strong> {{ $order->created_at->toDateString() }}</p>
    
    <p>This order is currently being processed. Please ensure that it is handled in a timely manner.</p>
    
    <p>If any follow-up is required, you may contact the customer or coordinate with the fulfillment team as needed.</p>
    
    <p>For any assistance or issues, please contact the support team at <a href="mailto:service@safetyeyeguard.com">service@safetyeyeguard.com</a> or call <a href="tel:8443005773">844-300-5773</a>.</p>
    
    <p>Thank you,<br>
    Safety Eye Guard System Notification</p>
    
    <hr>
    
    <p style="text-align: center;">This is an automated message for administrative purposes. No action is required unless follow-up is needed.</p>
</body>
</html>
