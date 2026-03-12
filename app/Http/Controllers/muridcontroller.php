<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\murid;

class muridcontroller extends Controller
{
   public function index(Request $request)
    {
        $query = murid::query();

        // 1. SEARCHING
        if ($request->has('search')) {
            $query->where('nama_murid', 'like', '%' . $request->search . '%');
        }

        // 2. SORTING
        $sortOrder = $request->input('sort', 'asc'); 
        $query->orderBy('nama_murid', $sortOrder);

        // 3. PAGINATION
        $limit = $request->input('limit', 3);
        $data = $query->paginate($limit);

        return response()->json([
            'message' => 'Berhasil mengambil data murid',
            'data' => $data
        ]);
    }
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'nama_murid' => 'required|string',
        ]);

        $murid = murid::create($validatedData);
        return response()->json(['murid' => $murid]);
    }
    public function show(string $id)
    {
        $murid = murid::find($id);
        if($murid){
            return Response() -> json(['murid' => $murid]);
        } else{
            return Response() -> json(['message' => 'murid tidak terdaftar'], 404);
        }
        
    }
   public function update(Request $request, string $id)
    {
        $validatedData = $request->validate([
        'nama_murid' => 'required|string',
        ]);
        
        $murid = murid::where('id_murid',$id) -> first();
                
        if (!$murid) {
            return response()->json(['message' => 'murid belum terdaftar'], 404);
        } 

        $murid->update($validatedData);  
        return response()->json(['message' => 'Data murid berhasil di update', 'murid' => $murid]);
    }
    public function destroy(string $id)
    {
        $murid = murid::find($id);
        if (!$murid) {
             return response()->json(['message' => 'murid belum terdaftar'], 404);
        }
        $murid->delete();
        return response()->json(['message' => 'Data murid berhasil di hapus']);
    }
}
