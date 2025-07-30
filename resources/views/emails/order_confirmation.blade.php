<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
        body {
            background-color: #f3f4f6;
            margin: 0;
            font-family: sans-serif;
        }

        .container {
            max-width: 64rem;
            margin: 2.5rem auto;
            background-color: rgba(255, 255, 255, 0.4);
            padding: 2rem;
        }

        .top-bar {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
        }

        .line {
            flex-grow: 1;
            height: 2px;
            background-color: #000;
            margin-right: 1rem;
            margin-top: 1rem;
            width: 90%
        }

        .logo {
            height: 4rem;
            width: auto;
        }

        .name-section {
            margin-bottom: 2.5rem;
        }

        .name-content {
            display: flex;
            flex-direction: column;
        }

        @media (min-width: 768px) {
            .name-content {
                flex-direction: row;
                justify-content: space-between;
            }

            .product-image {
                margin-top: 0;
                margin-left: auto;
            }
        }

        .product-image {
            margin-top: 1rem;
            height: 10rem;
            width: auto;
        }

        .section-table {
            width: 100%;
            margin-bottom: 1.5rem;
            font-size: 0.875rem;
        }

        .section-table .row-header {
            display: flex;
            justify-content: space-between;
            border-bottom: 2px solid #000;
            font-weight: bold;
            padding: 0.5rem 0;
        }

        .section-table .row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid #d1d5db;
        }

        .row .label,
        .row-header .label {
            text-align: left;
            width: 45%;
        }

        .row .value,
        .row-header .value {
            text-align: right;
            width: 55%;
        }

        .payment-section {
            font-size: 0.875rem;
            margin-top: 3rem;
        }

        .payment-top {
            display: flex;
            justify-content: space-between;
            margin-bottom: 2rem;
        }

        .payment-top .title {
            font-weight: bold;
        }

        .payment-top .details {
            text-align: right;
        }

        .payment-top .details div {
            margin-bottom: 0.25rem;
        }

        .payment-top .details .highlight {
            font-weight: bold;
        }

        .footer {
            display: flex;
            justify-content: space-between;
            border-top: 1px solid #000;
            padding-top: 1.5rem;
            margin-top: 2.5rem;
            font-weight: bold;
        }

        .footer .address {
            text-align: right;
            font-weight: normal;
        }
    </style>
</head>

<body>
    <div class="container">
        <!-- Top Bar -->
        <div class="top-bar">
            <div class="line"></div>
            <img src="https://srv828423.hstgr.cloud/projectimages/company_logos/logowhite.e9586f006040d8d52c01.png" alt="Logo" class="logo" />
        </div>

        <!-- Name Section -->
        <div class="name-section">
            <div class="name-content">
                <div>
                    <h1 style="font-size: 1.5rem; font-weight: bold;">Name: {{$order->shipping_address->first_name.' '.$order->shipping_address->last_name}}</h1>
                    <p style="font-size: 0.875rem;">Phone: {{$order->shipping_address->phone_number}}</p>
                    <p style="font-size: 0.875rem;">Email: {{$order->shipping_address->email}}</p>
                </div>
                <div class="product-image">
                    <img src="https://srv828423.hstgr.cloud/projectimages/products/{{$order->product->featured_image}}" alt="Product Image" class="product-image" />
                </div>
            </div>
        </div>

        <!-- Specs Table - ITEM -->
        <div class="section-table">
            <div class="row-header">
                <div class="label">ITEM</div>
                <div class="value">DESCRIPTION</div>
            </div>
            <div class="row">
                <div class="label">Frame:</div>
                <div class="value">{{$order->product->product_name}}</div>
            </div>
            <div class="row">
                <div class="label">Color:</div>
                <div class="value">{{$order->variant->color_name}}</div>
            </div>
            <div class="row">
                <div class="label">Size:</div>
                <div class="value">{{$order->frame_size_formail->frame_size_name}}</div>
            </div>
        </div>

        <!-- Specs Table - LENSES -->
        <div class="section-table">
            <div class="row-header">
                <div class="label">LENSES</div>
                <div class="value">DESCRIPTION</div>
            </div>
            <div class="row">
                <div class="label">Lens Type:</div>
                <div class="value">{{$order->prescription->frame_prescription}}</div>
            </div>
            <div class="row">
                <div class="label">Lens Protection:</div>
                <div class="value">{{$order->lens_protection_formail->title}}</div>
            </div>
            <div class="row">
                <div class="label">Blue Light Protection:</div>
                <div class="value">{{$order->blue_light_protection_formail->title}}</div>
            </div>
        </div>

        <!-- Payment Section -->
        <div class="payment-section">
            <div class="payment-top">
                <div class="title">PAYMENT DETAILS</div>
                <div class="details" style="margin-left: auto">
                    <div>Total Payment: <span>{{$order->net_total}}</span></div>
                    <div class="highlight">BENEFIT AMOUNT WAS USED: <span>{{$order->paid_amount_via_benefit}}</span></div>
                </div>
            </div>

            <div class="footer">
                <div>SAFETYEYEGUARD.COM</div>
                <div class="address">12720 Hillcrest Rd, Suite 702, Dallas, TX 75230</div>
            </div>
        </div>
    </div>
</body>

</html>
