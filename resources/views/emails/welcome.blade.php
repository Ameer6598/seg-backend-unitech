<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Our Platform</title>
    <script src="https://cdn.jsdelivr.net/npm/tailwindcss@3.0.0/dist/tailwind.min.css"></script>
</head>
<body class="bg-gray-100 text-gray-900 font-sans">
    <div class="max-w-lg mx-auto mt-10 p-6 bg-white shadow-md rounded-lg">
        <h1 class="text-3xl font-bold text-center text-indigo-600 mb-6">Welcome, {{ $userData['name'] }}!</h1>
        
        <p class="text-lg mb-4">Thank you for registering with us. Your account has been successfully created.</p>
        
        <h3 class="text-2xl font-semibold mb-4 text-gray-700">Account Details:</h3>
        
        <p class="text-lg mb-4">Please click the link below to set your new password and activate your account:</p>
        
        <div class="text-center">
            <a href="{{ $userData['verification_link'] }}" class="inline-block px-6 py-3 text-white bg-indigo-600 rounded-lg hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-400">
                Set Your New Password
            </a>
        </div>
        
        <p class="text-sm text-gray-600 mt-4">If you did not create this account, please ignore this email.</p>
        
        <div class="mt-6 text-center">
            <p class="text-sm text-gray-600">Best regards,<br>Unitech Digital Studio</p>
        </div>
    </div>
</body>
</html>
