<?php

namespace App\Observers;

use App\Models\User;
use Illuminate\Support\Facades\Mail;
use App\Mail\SendMailToNewUser;

class UserObserver
{
    /**
     * Handle the User "created" event.
     */
    public function created(User $user): void
    {
        $verificationLink = url('https://safteyguard.vercel.app/orders/' . $user->id . '/' . $user->verification_number);

            Mail::to($user->email)->queue(new SendMailToNewUser([
                'id' => $user->id,
                'name' => $user->name,
                'verification_number' => $user->verification_number,
                'verification_link' => $verificationLink,
            ]));

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
