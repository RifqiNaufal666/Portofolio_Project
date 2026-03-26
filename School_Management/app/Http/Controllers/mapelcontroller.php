<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\guru;
use App\Models\mapel;

class mapelcontroller extends Controller
{ 
   public function index(Request $request)
    {
        $query = mapel::with(['data_guru']);

        // 1. SEARCHING (Berdasarkan nama_mapel)
        if ($request->has('search')) {
            $query->where('nama_mapel', 'like', '%' . $request->search . '%');
        }

        // 2. SORTING (Berdasarkan nama_mapel)
        $sortOrder = $request->input('sort', 'asc'); 
        $query->orderBy('nama_mapel', $sortOrder);

        // 3. PAGINATION
        $limit = $request->input('limit', 5);
        $data = $query->paginate($limit);

        return response()->json([
            'message' => 'Berhasil mengambil data mapel',
            'data' => $data
        ]);
    }
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'nama_mapel' => 'required|string',
            'id_guru' => 'required|numeric',
            'id_murid' => 'required|numeric'
        ]);

        $mapel = mapel::create($validatedData);
        return response()->json(['mapel' => $mapel]);
    }
    public function show(string $id)
    {
        $mapel = mapel::find($id);
        if($mapel){
            return Response() -> json(['mapel' => $mapel]);
        } else{
            return Response() -> json(['message' => 'mapel tidak terdaftar'], 404);
        }
        
    }
   public function update(Request $request, string $id)
    {
        $validatedData = $request->validate([
        'nama_mapel' => 'required|string',
        ]);
        
        $mapel = mapel::where('id_mapel',$id) -> first();
                
        if (!$mapel) {
            return response()->json(['message' => 'mapel belum terdaftar'], 404);
        } 

        $mapel->update($validatedData);  
        return response()->json(['message' => 'Data mapel berhasil di update', 'mapel' => $mapel]);
    }
    public function destroy(string $id)
    {
        $mapel = mapel::find($id);
        if (!$mapel) {
             return response()->json(['message' => 'mapel belum terdaftar'], 404);
        }
        $mapel->delete();
        return response()->json(['message' => 'Data mapel berhasil di hapus']);
 }
}