<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sparepart extends Model
{
    use HasFactory;

    // Isi data secara massal
    protected $fillable = ['name', 'stock', 'price'];
    public function serviceLogs() {return $this->hasMany(ServiceLog::class);}
}
