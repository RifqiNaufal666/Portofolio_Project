<?php

namespace App\Http\Controllers;

use App\Models\ServiceLog;
use App\Models\Mechanic;
use App\Models\Sparepart;
use Illuminate\Http\Request;

class ServiceLogController extends Controller
{
    /**
     * Menampilkan daftar riwayat servis.
     * Menggunakan Eager Loading (with) untuk menghindari N+1 Query Problem.
     */
    public function index() {
        $logs = ServiceLog::with('sparepart','mechanic')->get();
        return view('services.index', compact('logs'));
    }

    /**
     * Menampilkan form tambah data servis.
     * Mengambil master data sparepart dan mekanik untuk dropdown.
     */
    public function create() {
        $spareparts = Sparepart::all();
        $mechanics = Mechanic::all();
        return view('services.create', compact('spareparts', 'mechanics'));
    }

    /**
     * Menyimpan data servis baru ke database dan mengurangi stok.
     */
    public function store(Request $request) {
        $validated = $request->validate([
            'customer_name' => 'required',
            'motorcycle_model' => 'required',
            'sparepart_id' => 'required|exists:spareparts,id',
            'mechanic_id' => 'required|exists:mechanics,id',
            'quantity' => 'required|integer|min:1',
            'service_date' => 'required|date',
        ]);

        // 1. Ambil data sparepart yang dipilih
        $sparepart = Sparepart::findOrFail($request->sparepart_id);

        // 2. Cek apakah stok mencukupi?
        if ($sparepart->stock < $request->quantity) {
            // Jika kurang, kembalikan user ke form dengan pesan error
            return back()->withErrors(['quantity' => 'Gagal! Stok sparepart tidak mencukupi. Sisa stok: ' . $sparepart->stock])->withInput();
        }

        // 3. Jika stok aman, simpan data log servis
        ServiceLog::create($validated);

        // 4. Decrement stok sparepart sesuai jumlah (quantity) yang dipakai
        $sparepart->decrement('stock', $request->quantity);

        return redirect('/services')->with('success', 'Data servis berhasil dicatat !');
    }

    /**
     * Menampilkan form edit berdasarkan ID.
     */
    public function edit($id) {
        // findOrFail otomatis menampilkan halaman 404 if ID tidak ditemukan di database
        $service = ServiceLog::findOrFail($id);
        $spareparts = Sparepart::all();
        $mechanics = Mechanic::all();
        
        return view('services.edit', compact('service', 'spareparts', 'mechanics'));
    }

    /**
     * Memperbarui data di database.
     */
    public function update(Request $request, $id) {
        $validated = $request->validate([
            'customer_name' => 'required',
            'motorcycle_model' => 'required',
            'sparepart_id' => 'required|exists:spareparts,id',
            'mechanic_id' => 'required|exists:mechanics,id',
            'quantity' => 'required|integer|min:1',
            'service_date' => 'required|date',
        ]);

        $service = ServiceLog::findOrFail($id);
        $service->update($validated);

        return redirect('/services')->with('success', 'Riwayat servis berhasil diperbarui!');
    }

    /**
     * Menghapus riwayat servis dari database.
     */
    public function destroy($id) {
        $service = ServiceLog::findOrFail($id);
        $service->delete();

        return redirect('/services')->with('success', 'Riwayat servis berhasil dihapus!');
    }
}
