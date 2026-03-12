<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
// use App\Models\guru;

class mapel extends Model
{
    use HasFactory;
    protected $fillable = ['id_guru','id_murid','nama_mapel'];
    protected $table = 'mapel'; protected $primaryKey = 'id_mapel'; protected $ForeignKey = ['id_guru', 'id_murid'];

    public function data_guru(){
        return $this->belongsTo(guru::class, 'id_guru', 'id_guru');
    }
}
