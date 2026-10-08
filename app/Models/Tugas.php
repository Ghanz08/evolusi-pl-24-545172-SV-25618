<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tugas extends Model
{
    protected $table = 'tugas';

    protected $fillable = [
        'judul',
        'deskripsi',
        'selesai',
    ];

    protected $casts = [
        'selesai' => 'boolean',
    ];

    public function scopeSelesai($query)
    {
        return $query->where('selesai', true);
    }

    public function scopeBelumSelesai($query)
    {
        return $query->where('selesai', false);
    }
}
