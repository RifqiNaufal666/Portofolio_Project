<?php

namespace App\Http\Controllers;

use App\Models\Sparepart;
use Illuminate\Http\Request;

class SparepartController extends Controller
{
    /**
     * Menampilkan semua data stok sparepart dari database.
     */
    public function index() {
        $spareparts = Sparepart::all();
        return view('spareparts.index', compact('spareparts'));
    }
    
    /**
     * Menampilkan form input sparepart baru.
     */
    public function create() {
        return view('spareparts.create');
    }

    /**
     * Memproses penyimpanan data sparepart.
     */
    public function store(Request $request) {
        // Validasi: Memastikan data yang diinput sesuai tipe dan tidak kosong
        $request->validate([
            'name'  => 'required|string|max:255',
            'stock' => 'required|integer|min:0',
            'price' => 'required|numeric|min:0',
        ]);

        // ORM: Menyimpan seluruh input yang tervalidasi ke tabel spareparts
        Sparepart::create($request->all());

        return redirect('/spareparts')->with('success', 'Sparepart berhasil ditambahkan!');
    }

    /**
     * Menampilkan form edit sparepart dengan data yang sudah ada.
     */
    public function edit($id) {
        $sparepart = Sparepart::findOrFail($id);
        return view('spareparts.edit', compact('sparepart'));
    }

    /**
     * Memperbarui data sparepart spesifik.
     */
    public function update(Request $request, $id) {
        $request->validate([
            'name'  => 'required',
            'stock' => 'required|integer',
            'price' => 'required|numeric',
        ]);

        $sparepart = Sparepart::findOrFail($id);
        $sparepart->update($request->all());

        return redirect('/spareparts')->with('success', 'Data berhasil diperbarui!');
    }

    /**
     * Menghapus data sparepart menggunakan metode HTTP DELETE.
     */
    public function destroy($id) {
        $sparepart = Sparepart::findOrFail($id);
        $sparepart->delete();

        return redirect('/spareparts')->with('success', 'Data berhasil dihapus!');
    }
}
