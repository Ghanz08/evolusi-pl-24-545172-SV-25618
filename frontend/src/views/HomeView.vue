<template>
  <div class="page-container">
    <header class="header">
      <span class="badge">Evolusi Perangkat Lunak 2026</span>
      <h1>Sistem Manajemen Tugas</h1>
      <p class="subtitle">Aplikasi SPA dibangun dengan Vue 3 dan Laravel 12 API.</p>
    </header>

    <div class="card-grid">
      <div class="card">
        <h3>Status Lingkungan</h3>
        <p><strong>API Endpoint:</strong> <code>{{ apiUrl }}</code></p>
        <p><strong>NIM Mahasiswa:</strong> <code>24-545172-SV-25618</code></p>
      </div>

      <div class="card action-card">
        <h3>Kelola Data</h3>
        <p>Akses daftar tugas yang terhubung secara realtime dengan REST API backend.</p>
        <router-link to="/tugas" class="btn btn-primary">Buka Daftar Tugas &rarr;</router-link>
      </div>
    </div>
  </div>
</template>

<script setup>
const apiUrl = import.meta.env.VITE_API_URL || 'Not configured'
</script>

<style scoped>
.page-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem 1rem;
}
.header {
  margin-bottom: 2rem;
}
.badge {
  display: inline-block;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  background: #e0e7ff;
  color: #3730a3;
  margin-bottom: 0.75rem;
}
h1 {
  font-size: 2rem;
  font-weight: 700;
  color: #111827;
  margin: 0 0 0.5rem 0;
}
.subtitle {
  color: #4b5563;
  margin: 0;
}
.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1.5rem;
}
.card {
  background: #ffffff;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 1.5rem;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}
.card h3 {
  margin-top: 0;
  font-size: 1.15rem;
  color: #1f2937;
}
code {
  background: #f3f4f6;
  padding: 0.2rem 0.4rem;
  border-radius: 4px;
  font-size: 0.85rem;
  color: #c026d3;
}
.btn {
  display: inline-block;
  padding: 0.6rem 1.2rem;
  border-radius: 6px;
  font-weight: 600;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.2s;
  margin-top: 0.5rem;
}
.btn-primary {
  background: #2563eb;
  color: #ffffff;
}
.btn-primary:hover {
  background: #1d4ed8;
}
</style>
