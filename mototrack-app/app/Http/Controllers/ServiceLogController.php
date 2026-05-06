<?php

namespace App\Http\Controllers;

use App\Models\ServiceLog;
use App\Models\Mechanic;
use App\Models\Sparepart;
use Illuminate\Http\Request;

class ServiceLogController extends Controller
{
    public function index() {
        $logs = ServiceLog::with('sparepart','mechanic')->get();
        return view('services.index', compact('logs'));
    }

    public function create() {
    $spareparts = Sparepart::all();
    $mechanics = Mechanic::all();
    return view('services.create', compact('spareparts', 'mechanics'));
}

    public function store(Request $request) {
        $validated = $request->validate([
            'customer_name' => 'required',
            'motorcycle_model' => 'required',
            'sparepart_id' => 'required|exists:spareparts,id',
            'quantity' => 'required|integer|min:1',
            'service_date' => 'required|date',
        ]);

        ServiceLog::create($validated);

        return redirect('/services')->with('success', 'Data servis berhasil dicatat!');
    }

    public function edit($id) {
    $service = ServiceLog::findOrFail($id);
    $spareparts = Sparepart::all();
    $mechanics = Mechanic::all();
    return view('services.edit', compact('service', 'spareparts', 'mechanics'));
    }

    public function update(Request $request, $id) {
        $validated = $request->validate([
            'customer_name' => 'required',
            'motorcycle_model' => 'required',
            'sparepart_id' => 'required|exists:spareparts,id',
            'quantity' => 'required|integer|min:1',
            'service_date' => 'required|date',
        ]);

        $service = ServiceLog::findOrFail($id);
        $service->update($validated);

        return redirect('/services')->with('success', 'Riwayat servis berhasil diperbarui!');
    }

    public function destroy($id) {
        $service = ServiceLog::findOrFail($id);
        $service->delete();

        return redirect('/services')->with('success', 'Riwayat servis berhasil dihapus!');
    }
}
