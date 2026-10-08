<?php

namespace App\Http\Controllers;

use App\Models\Tugas;
use Illuminate\Http\Request;

class TugasController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Tugas::query();

        if ($request->has('selesai')) {
            $query->where('selesai', filter_var($request->query('selesai'), FILTER_VALIDATE_BOOLEAN));
        }

        return response()->json($query->latest()->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'judul' => 'required|string|max:255',
            'deskripsi' => 'nullable|string',
            'selesai' => 'boolean',
        ]);

        $tugas = Tugas::create($validated);

        return response()->json($tugas, 201);
    }

    public function show(Tugas $tugas)
    {
        return response()->json($tugas);
    }

    public function update(Request $request, Tugas $tugas)
    {
        $validated = $request->validate([
            'judul' => 'sometimes|required|string|max:255',
            'deskripsi' => 'nullable|string',
            'selesai' => 'boolean',
        ]);

        $tugas->update($validated);

        return response()->json($tugas);
    }

    public function destroy(Tugas $tugas)
    {
        $tugas->delete();

        return response()->json(['message' => 'Tugas berhasil dihapus']);
    }
}
