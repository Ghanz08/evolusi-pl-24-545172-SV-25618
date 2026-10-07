<?php

namespace Tests\Feature;

use App\Models\Tugas;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class TugasApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_can_list_tugas(): void
    {
        Tugas::create([
            'judul' => 'Belajar CI/CD',
            'deskripsi' => 'Praktikum Evolusi PL',
            'selesai' => false,
        ]);

        $response = $this->getJson('/api/tugas');

        // Sengaja digagalkan untuk membuktikan pipeline merah (Tugas 2 syarat 5)
        $response->assertStatus(500);
    }

    public function test_can_create_tugas(): void
    {
        $payload = [
            'judul' => 'Tugas Baru',
            'deskripsi' => 'Deskripsi tugas baru',
            'selesai' => false,
        ];

        $response = $this->postJson('/api/tugas', $payload);

        $response->assertStatus(201)
            ->assertJsonFragment([
                'judul' => 'Tugas Baru',
            ]);

        $this->assertDatabaseHas('tugas', [
            'judul' => 'Tugas Baru',
        ]);
    }
}
