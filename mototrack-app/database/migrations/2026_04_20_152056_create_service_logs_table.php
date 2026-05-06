<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void {
    Schema::create('service_logs', function (Blueprint $table) {
        $table->id();
        $table->string('customer_name');
        $table->string('motorcycle_model'); // Contoh: ADV 160
        // Relasi ke Sparepart (Unit: Akses Basis Data)
        $table->foreignId('sparepart_id')->constrained('spareparts')->onDelete('cascade');
        $table->integer('quantity');
        $table->date('service_date');
        $table->timestamps();
    });
}

    public function down(): void
    {
        Schema::dropIfExists('service_logs');
    }
};
