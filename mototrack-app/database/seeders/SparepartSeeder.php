<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Sparepart;

class SparepartSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void {
    Sparepart::create([
        'name' => 'Ban Luar Honda ADV',
        'stock' => 15,
        'price' => 350000
    ]);

    Sparepart::create([
        'name' => 'Oli Mesin SPX2',
        'stock' => 20,
        'price' => 65000
    ]);
}
}
