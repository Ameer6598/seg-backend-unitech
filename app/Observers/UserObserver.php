<?php

namespace App\Observers;

use App\Models\User;
use App\Mail\SendMailToNewUser;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Mail;


class UserObserver
{
    /**
     * Handle the User "created" event.
     */
    public function created(User $user): void
    {
        $apiKey = env('GHL_API_KEY');
        $baseUrl = 'https://rest.gohighlevel.com/v1';
    
        $verificationLink = url('https://app.safetyeyeguard.com/new-password/' . $user->id . '/' . $user->verification_number);
    

        $response = Http::withHeaders([
            'Authorization' => 'Bearer ' . $apiKey,
            'Content-Type' => 'application/json',
        ])->post($baseUrl . '/contacts/', [
            'email' => $user->email,
            'firstName' => $user->name,
            'phone' => $user->Employedata->phone ?? null,
            'role'=>$user->role,
            'customField' => [
                'verification_link' => $verificationLink
            ],
        ]);
        
    
        if ($response->successful()) {
            $contactId = $response->json('contact.id');
            Http::withHeaders([
                'Authorization' => 'Bearer ' . $apiKey,
                'Content-Type' => 'application/json',
            ])->post($baseUrl . '/contacts/' . $contactId . '/tags', [
                'tags' => ['verification_email  '], // Your workflow trigger tag
            ]);
        }
    }
    




    /**
     * Handle the User "updated" event.
     */
    public function updated(User $user): void
    {
        //
    }

    /**
     * Handle the User "deleted" event.
     */
    public function deleted(User $user): void
    {
        //
    }

    /**
     * Handle the User "restored" event.
     */
    public function restored(User $user): void
    {
        //
    }

    /**
     * Handle the User "force deleted" event.
     */
    public function forceDeleted(User $user): void
    {
        //
    }
}
