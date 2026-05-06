<?php

namespace App\Http\Controllers;

use App\Models\Sparepart;
use Illuminate\Http\Request;

class SparepartController extends Controller
{
    public function index() {
        $spareparts = Sparepart::all();
        return view('spareparts.index', compact('spareparts'));

    }
        public function create() {
        return view('spareparts.create');
    }

    public function store(Request $request) {
        // Validasi (Unit: Menulis Kode dengan Prinsip Guidelines)
        $request->validate([
            'name'  => 'required|string|max:255',
            'stock' => 'required|integer|min:0',
            'price' => 'required|numeric|min:0',
        ]);

        // Menggunakan Eloquent (Unit: OOP & Akses Basis Data)
        Sparepart::create($request->all());

        return redirect('/spareparts')->with('success', 'Sparepart berhasil ditambahkan!');
    }

    public function edit($id) {
    $sparepart = Sparepart::findOrFail($id);
    return view('spareparts.edit', compact('sparepart'));
}

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

    public function destroy($id) {
        $sparepart = Sparepart::findOrFail($id);
        $sparepart->delete();

        return redirect('/spareparts')->with('success', 'Data berhasil dihapus!');
    }


}
