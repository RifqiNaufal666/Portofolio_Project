<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class murid extends Model
{
        use HasFactory;
        protected $table = 'murid'; protected $primaryKey = 'id_murid';
        protected $fillable = ['nama_murid'];
}
