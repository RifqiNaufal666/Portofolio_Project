<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ServiceLog extends Model
{
    protected $fillable = ['customer_name', 'motorcycle_model', 'mechanic_id','sparepart_id', 'quantity', 'service_date'];

    public function sparepart()  {return $this->belongsTo(Sparepart::class);}
    public function mechanic()   {return $this->belongsTo(Mechanic::class);}
}