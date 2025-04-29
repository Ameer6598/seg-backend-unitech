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
                    Thank you for your order
                </p>
                <p style="font-size: 16px; color: #374151; margin-top: 12px;">
                    Your order confirmation number is: 
                    <strong style="color: #4f46e5;">{{ $order->order_confirmation_number }}</strong>
                </p>

            </div>

            <hr style="margin: 32px 0; border-color: #e5e7eb;">

            <p style="font-size: 14px; color: #6b7280; text-align: center;">
                If you have any questions, reply to this email or contact our support team.
            </p>
        </div>
    </div>
</body>
</html>
