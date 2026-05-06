<?php

namespace Database\Seeders;

use App\Models\Mechanic;
use Illuminate\Database\Seeder;

class MechanicSeeder extends Seeder
{
    public function run(): void
    {
        Mechanic::create([
            'name' => 'Rifqi',
            'specialization' => 'Spesialis Matic & Honda ADV'
        ]);

        Mechanic::create([
            'name' => 'Budi',
            'specialization' => 'Spesialis Kelistrikan'
        ]);

        Mechanic::create([
            'name' => 'Agus',
            'specialization' => 'Spesialis Mesin Besar'
        ]);
    }
}