<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ServiceLog extends Model
{
    /**
     * Field yang diizinkan untuk diisi secara massal (Mass Assignment Protection).
     */
    protected $fillable = ['customer_name', 'motorcycle_model', 'mechanic_id','sparepart_id', 'quantity', 'service_date'];

    /**
     * Relasi Many-to-One ke tabel Spareparts.
     * Setiap riwayat servis milik/berkaitan dengan 1 Sparepart.
     */
    public function sparepart() {
        return $this->belongsTo(Sparepart::class);
    }
    
    /**
     * Relasi Many-to-One ke tabel Mechanics.
     * Setiap riwayat servis dikerjakan oleh 1 Mekanik.
     */
    public function mechanic() {
        return $this->belongsTo(Mechanic::class);
    }
}