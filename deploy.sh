#!/usr/bin/env bash
set -e

echo "=== Memulai Deployment Laravel ==="
echo "Langkah 1: Mengaktifkan mode maintenance..."
echo "Langkah 2: Menarik kode terbaru dari repository..."
echo "Langkah 3: Memasang dependensi Composer (tanpa dev)..."
echo "Langkah 4: Menjalankan migrasi database..."
echo "Langkah 5: Membersihkan dan memuat ulang cache aplikasi..."
echo "Langkah 6: Membangun aset frontend..."
echo "Langkah 7: Mematikan mode maintenance (aplikasi aktif)..."
echo "=== Deployment Selesai Berhasil ==="
