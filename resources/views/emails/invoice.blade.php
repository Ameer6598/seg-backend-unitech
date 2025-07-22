<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice - Order #{{ $order->order_confirmation_number }}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f9fafb;
            color: #374151;
            line-height: 1.6;
            padding: 2rem 1rem;
        }

        .invoice-container {
            max-width: 42rem;
            margin: 0 auto;
            background: white;
            border-radius: 0.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            color: white;
            padding: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 1.5rem;
            font-weight: 700;
        }

        .header .order-number {
            color: #bfdbfe;
            font-size: 0.875rem;
        }

        .header .date-info {
            text-align: right;
        }

        .header .date-label {
            color: #bfdbfe;
            font-size: 0.875rem;
        }

        .content {
            padding: 1.5rem;
        }

        .section {
            margin-bottom: 1.5rem;
        }

        .section-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 0.75rem;
        }

        .info-card {
            background-color: #f9fafb;
            padding: 1rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
        }

        .customer-name {
            font-weight: 500;
            color: #111827;
            margin-bottom: 0.25rem;
        }

        .info-row {
            display: flex;
            align-items: center;
            margin-top: 0.25rem;
            color: #6b7280;
        }

        .icon {
            width: 1rem;
            height: 1rem;
            margin-right: 0.5rem;
            flex-shrink: 0;
        }

        .details-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            font-size: 0.875rem;
        }

        .detail-item {
            color: #6b7280;
        }

        .detail-value {
            margin-left: 0.5rem;
            font-weight: 500;
            color: #111827;
        }

        .product-table {
            background-color: #f9fafb;
            border-radius: 0.5rem;
            overflow: hidden;
        }

        .table-header {
            background-color: #e5e7eb;
            padding: 0.75rem 1rem;
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr 1fr;
            gap: 1rem;
            font-size: 0.75rem;
            font-weight: 500;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .table-row {
            background: white;
            padding: 1rem;
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr 1fr;
            gap: 1rem;
            align-items: center;
        }

        .product-info h4 {
            font-weight: 500;
            color: #111827;
            margin-bottom: 0.25rem;
        }

        .manufacturer {
            font-size: 0.875rem;
            color: #6b7280;
        }

        .price-total {
            text-align: right;
        }

        .total-section {
            background-color: #f9fafb;
            padding: 1rem;
            border-radius: 0.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-label {
            font-size: 1.125rem;
            font-weight: 600;
            color: #1f2937;
        }

        .total-amount {
            font-size: 1.5rem;
            font-weight: 700;
            color: #2563eb;
        }

        .payment-section {
            border-top: 1px solid #e5e7eb;
            padding-top: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .payment-status {
            display: flex;
            align-items: center;
            font-size: 0.875rem;
            color: #6b7280;
        }

        .status-badge {
            margin-left: 0.5rem;
            padding: 0.25rem 0.5rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .status-pending {
            background-color: #fef3c7;
            color: #92400e;
        }

        .status-paid {
            background-color: #d1fae5;
            color: #065f46;
        }

        .pay-btn {
            background-color: #2563eb;
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 0.5rem;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.2s;
            display: inline-flex;
            align-items: center;
        }

        .pay-btn:hover {
            background-color: #1d4ed8;
        }

        .footer {
            background-color: #f9fafb;
            padding: 1rem 1.5rem;
            border-top: 1px solid #e5e7eb;
            text-align: center;
            font-size: 0.875rem;
            color: #6b7280;
        }

        @media (max-width: 640px) {
            .header {
                flex-direction: column;
                text-align: center;
                gap: 0.5rem;
            }

            .details-grid {
                grid-template-columns: 1fr;
            }

            .table-header,
            .table-row {
                grid-template-columns: 1fr;
                gap: 0.5rem;
            }

            .payment-section {
                flex-direction: column;
                gap: 1rem;
                align-items: stretch;
            }
        }
    </style>
</head>

<body>
    <div class="invoice-container">
        <!-- Header -->
        <div class="header">
            <div>
                <h1>INVOICE</h1>
                <p class="order-number">#{{ $order->order_confirmation_number }}</p>
            </div>
            <div class="date-info">
                <p class="date-label">Issue Date</p>
                <p>{{ $order->created_at->format('M d, Y') }}</p>
            </div>
        </div>

        <!-- Content -->
        <div class="content">
            <!-- Customer Info -->
            <div class="section">
                <h2 class="section-title">Bill To</h2>
                <div class="info-card">
                    <p class="customer-name">{{ $order->billing_address->first_name }}
                        {{ $order->billing_address->last_name }}</p>
                    <div class="info-row">
                        <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                        </svg>
                        <span>{{ $order->billing_address->address }}@if ($order->billing_address->second_address)
                                , {{ $order->billing_address->second_address }}
                            @endif, {{ $order->billing_address->city }},
                            {{ $order->billing_address->state }}, {{ $order->billing_address->country }}
                            {{ $order->billing_address->zip_postal_code }}</span>
                    </div>
                    <div class="info-row">
                        <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                        </svg>
                        <span>{{ $order->billing_address->email }}</span>
                    </div>
                    <div class="info-row">
                        <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                        </svg>
                        <span>{{ $order->billing_address->phone_number }}</span>
                    </div>
                </div>
            </div>

            <!-- Order Details -->
            <div class="section">
                <h2 class="section-title">Order Details</h2>
                <div class="info-card">
                    <div class="details-grid">
                        <div class="detail-item">
                            <span>Order Type:</span>
                            <span class="detail-value">{{ $order->order_type }}</span>
                        </div>
                        <div class="detail-item">
                            <span>Quantity:</span>
                            <span class="detail-value">{{ $order->product_quantity }}</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product Table -->
            <div class="section">
                <h2 class="section-title">Items</h2>
                <div class="product-table">
                    <div class="table-header">
                        <div>Product</div>
                        <div>SKU</div>
                        <div>Qty</div>
                        <div>Price</div>
                        <div>Total</div>
                    </div>
                    <div class="table-row">
                        <div class="product-info">
                            <h4>{{ $order->product->product_name }}</h4>
                            <p class="manufacturer">{{ $order->product->manufacturer->manufacturer_name ?? 'N/A' }}</p>
                        </div>
                        <div>{{ $order->product->sku }}</div>
                        <div>{{ $order->product_quantity }}</div>
                        <div>${{ number_format($order->net_total / $order->product_quantity, 2) }}</div>
                        <div class="price-total">${{ number_format($order->net_total, 2) }}</div>
                    </div>
                </div>
            </div>

            <!-- Total Section -->
            <div class="section">
                <div class="total-section">
                    <span class="total-label">Amount to be pay:</span>
                    <span class="total-amount">${{ number_format($order->paid_amount_via_card, 2) }}</span>
                </div>
            </div>

            <!-- Payment Breakdown -->
            <div class="section">
                <h2 class="section-title">Payment Breakdown</h2>
                <div class="info-card">
                    <div class="info-row">
                        <strong>Paid via Benefit:</strong>
                        <span class="detail-value">${{ number_format($order->paid_amount_via_benefit, 2) }}</span>
                    </div>
                    <div class="info-row">
                        <strong>Paid via Card:</strong>
                        <span class="detail-value">${{ number_format($order->paid_amount_via_card, 2) }}</span>
                    </div>
                       <div class="total-section">
                    <span class="total-label">Total Amount</span>
                    <span class="total-amount">${{ number_format($order->net_total, 2) }}</span>
                </div>
                </div>
            </div>

            <!-- Payment Section -->
            <div class="payment-section">
                <div class="payment-status">
                    <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                    </svg>
                    <span>Payment Status:</span>
                    <span
                        class="status-badge {{ $order->payment_status === 'paid' ? 'status-paid' : 'status-pending' }}">
                        {{ ucfirst($order->payment_status) }}
                    </span>
                </div>

                @if ($order->payment_status !== 'paid' && $order->stripe_invoice_url)
                    <a href="{{ $order->stripe_invoice_url }}" class="pay-btn" style="color: white; ">
                        <svg class="icon" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                            style="margin-right: 0.5rem;">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                        </svg>
                        Pay Now
                    </a>
                @endif
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>Thank you for your business! For questions, contact us at info@safetyeyeguard.com</p>
        </div>
    </div>
</body>

</html>
