<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Password Reset</title>
    <script src="https://cdn.jsdelivr.net/npm/tailwindcss@3.0.0/dist/tailwind.min.css"></script>
</head>
<body class="bg-gray-100 font-sans">
    <div class="max-w-lg mx-auto my-8 bg-white rounded-lg shadow-lg p-6">
        <div class="text-center">
            <h1 class="text-2xl font-bold text-gray-800 mb-4">Reset Your Password</h1>
            <p class="text-gray-600 mb-6">Hi {{ $name }},</p>
            <p class="text-gray-600 mb-6">You requested to reset your password. Click the button below to proceed:</p>
            <a href="{{ $link }}" class="inline-block bg-blue-600 text-white font-semibold py-2 px-4 rounded hover:bg-blue-700 transition duration-200">Reset Password</a>
            <p class="text-gray-500 text-sm mt-6">If you didn’t request this, please ignore this email.</p>
        </div>
        <div class="mt-8 text-center">
            <p class="text-gray-600 text-sm">Thanks,</p>
            <p class="text-gray-600 text-sm font-semibold">Safety Eye Guard Team</p>
        </div>
    </div>
</body>
</html>