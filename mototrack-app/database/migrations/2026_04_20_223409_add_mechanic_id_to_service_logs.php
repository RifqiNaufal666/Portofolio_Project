<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void {
    Schema::table('service_logs', function (Blueprint $table) {
        $table->foreignId('mechanic_id')->
        nullable()->constrained('mechanics')->
        onDelete('set null');//meskipun mekanik telah dihapus datanya, riwayat servis tetap utuh
    });
}

    public function down(): void
    {
        Schema::table('service_logs', function (Blueprint $table) {
            
        });
    }
};
