<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\guru;
use Illuminate\Http\Response;
    
class gurucontroller extends Controller
{
public function index(Request $request)
    {
        $query = guru::query();

        // 1. SEARCHING
        if ($request->has('search')) {
            $query->where('nama_guru', 'like', '%' . $request->search . '%');
        }

        // 2. SORTING
        $sortOrder = $request->input('sort', 'asc'); 
        $query->orderBy('nama_guru', $sortOrder);

        // 3. PAGINATION
        $limit = $request->input('limit', 3);
        $data = $query->paginate($limit);

        return response()->json([
            'message' => 'Berhasil mengambil data guru',
            'data' => $data
        ]);
    }
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'nama_guru' => 'required|string',
        ]);

        $guru = guru::create($validatedData);
        return response()->json(['guru' => $guru]);
    }
    public function show(string $id)
    {
        $guru = guru::find($id);
        if($guru){
            return Response() -> json(['guru' => $guru]);
        } else{
            return Response() -> json(['message' => 'Guru tidak terdaftar'], 404);
        }
        
    }
   public function update(Request $request, string $id)
    {
        $validatedData = $request->validate([
        'nama_guru' => 'required|string',
        ]);
        
        $guru = guru::where('id_guru',$id) -> first();
                
        if (!$guru) {
            return response()->json(['message' => 'Guru belum terdaftar'], 404);
        } 

        $guru->update($validatedData);  
        return response()->json(['message' => 'Data guru berhasil di update', 'guru' => $guru]);
    }
    public function destroy(string $id)
    {
        $guru = guru::find($id);
        if (!$guru) {
             return response()->json(['message' => 'Guru belum terdaftar'], 404);
        }
        $guru->delete();
        return response()->json(['message' => 'Data guru berhasil di hapus']);
    }
}
