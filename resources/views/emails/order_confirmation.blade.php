<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            padding: 0;
        }
        .email-container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 32px;
        }
        .btn {
            display: inline-block;
            background-color: #4f46e5;
            color: #ffffff;
            padding: 12px 24px;
            border-radius: 6px;
            text-decoration: none;
            margin-top: 20px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div style="padding: 40px 0;">
        <div class="email-container">
            <div style="text-align: center;">
                <h1 style="font-size: 24px; font-weight: bold; color: #1f2937;">Order Confirmation</h1>
                <p style="font-size: 16px; color: #4b5563; margin-top: 16px;">
                    Hello,
                </p>
                <p style="font-size: 16px; color: #374151; margin-top: 12px; text-align: left;">
                    Thank you for placing your order with Safety Eye Guard. We're excited to help you protect your vision with safety eyewear you can trust.
                </p>
                <p style="font-size: 16px; color: #374151; margin-top: 12px; text-align: left;">
                    We’ve received your order and it is now being processed.
                </p>
            </div>

            <hr style="margin: 32px 0; border-color: #e5e7eb;">

            <div style="text-align: left;">
                <h2 style="font-size: 18px; font-weight: bold; color: #1f2937;">Order Summary</h2>
                <p style="font-size: 16px; color: #374151; margin-top: 12px;">
                    <strong>Product:</strong> 
                </p>
                <p style="font-size: 16px; color: #374151; margin-top: 8px;">
                    <strong>Order ID:</strong> <span style="color: #4f46e5;">{{ $order->order_id }}</span>
                </p>
                <p style="font-size: 16px; color: #374151; margin-top: 8px;">
                    <strong>Order Date:</strong> {{ $order->order_date }}
                </p>
            </div>

            <hr style="margin: 32px 0; border-color: #e5e7eb;">

            <p style="font-size: 16px; color: #374151; text-align: left;">
                You’ll receive a notification with tracking details as soon as your order has been shipped.
            </p>
            <p style="font-size: 16px; color: #374151; text-align: left; margin-top: 12px;">
                In the meantime, you can check your order status anytime by logging into your company’s Safety Eye Guard account.
            </p>
            <p style="font-size: 16px; color: #374151; text-align: left; margin-top: 12px;">
                If you have any questions or need assistance, we’re here to help every step of the way. Feel free to reach out to us at 
                <a href="mailto:service@safetyeyeguard.com" style="color: #4f46e5; text-decoration: none;">service@safetyeyeguard.com</a> or call 
                <a href="tel:+18443005773" style="color: #4f46e5; text-decoration: none;">(844) 300-5773</a>.
            </p>
            <p style="font-size: 16px; color: #374151; text-align: left; margin-top: 12px;">
                Thank you once again for choosing Safety Eye Guard. We’re proud to support your workplace safety and are committed to delivering eyewear that fits your needs, comfortably, reliably, and on time.
            </p>
            <p style="font-size: 16px; color: #374151; text-align: left; margin-top: 12px;">
                Stay safe,<br>
                The Safety Eye Guard Team
            </p>

            <hr style="margin: 32px 0; border-color: #e5e7eb;">

            <p style="font-size: 14px; color: #6b7280; text-align: center;">
                If you have any questions, reply to this email or contact our support team.
            </p>
        </div>
    </div>
</body>
</html>