<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Our Platform</title>
    <script src="https://cdn.jsdelivr.net/npm/tailwindcss@3.0.0/dist/tailwind.min.css"></script>
</head>
<body class="bg-gray-50 text-gray-900 font-sans">
    <div class="max-w-3xl mx-auto mt-16 p-8 bg-white shadow-lg rounded-xl">
        <h1 class="text-4xl font-bold text-center text-indigo-600 mb-8">Welcome, {{ $userData['name'] }}!</h1>
        
        <p class="text-xl text-gray-800 mb-6">Thank you for registering with us. Your account has been successfully created, and we are excited to have you on board!</p>
        
        <h3 class="text-2xl font-semibold text-gray-700 mb-4">Account Activation:</h3>
        
        <p class="text-lg text-gray-700 mb-4">To get started, please click the link below to set your new password and activate your account:</p>
        
        <div class="text-center">
            <a href="{{ $userData['verification_link'] }}" class="inline-block px-8 py-4 text-white bg-indigo-600 rounded-lg shadow-md hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-400 transition">
                Set Your New Password
            </a>
        </div>
        
        <p class="text-sm text-gray-600 mt-6 text-center">If you did not create this account, please disregard this message.</p>
        
        <div class="mt-8 text-center">
            <p class="text-sm text-gray-600">Best regards,<br><strong>Unitech Digital Studio</strong></p>
        </div>
    </div>
</body>
</html>
