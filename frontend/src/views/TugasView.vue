<template>
  <div class="page-container">
    <div class="top-nav">
      <router-link to="/" class="back-link">&larr; Kembali ke Beranda</router-link>
    </div>

    <header class="header">
      <h2>Daftar Tugas Praktikum</h2>
      <p class="api-info">Data ditarik dari: <code>{{ apiUrl }}/tugas</code></p>
    </header>

    <!-- Form Tambah -->
    <div class="card form-card">
      <h3>Tambah Tugas Baru</h3>
      <form @submit.prevent="tambahTugas" class="form-layout">
        <div class="form-group">
          <label for="judul">Judul Tugas</label>
          <input
            id="judul"
            v-model="form.judul"
            type="text"
            placeholder="Contoh: Implementasi Vitest"
            required
          />
        </div>
        <div class="form-group">
          <label for="deskripsi">Deskripsi</label>
          <input
            id="deskripsi"
            v-model="form.deskripsi"
            type="text"
            placeholder="Catatan pengerjaan..."
          />
        </div>
        <button type="submit" :disabled="submitting" class="btn btn-primary">
          {{ submitting ? 'Menyimpan...' : 'Simpan Tugas' }}
        </button>
      </form>
    </div>

    <!-- State: Loading / Error / Data -->
    <div v-if="loading" class="state-box">Memuat data dari API...</div>
    <div v-else-if="error" class="state-box error-box">
      <p><strong>Gagal mengambil data dari backend.</strong></p>
      <p class="small-text">{{ error }}</p>
      <button @click="fetchTugas" class="btn btn-retry">Coba Lagi</button>
    </div>
    <div v-else-if="tugasList.length === 0" class="state-box empty-box">
      Belum ada data tugas. Silakan tambahkan melalui form di atas.
    </div>

    <div v-else class="tugas-list">
      <div
        v-for="item in tugasList"
        :key="item.id"
        class="tugas-item"
        :class="{ done: item.selesai }"
      >
        <div class="tugas-content">
          <h4>{{ item.judul }}</h4>
          <p v-if="item.deskripsi">{{ item.deskripsi }}</p>
          <span class="status-pill" :class="item.selesai ? 'pill-done' : 'pill-pending'">
            {{ formatStatus(item.selesai) }}
          </span>
        </div>
        <div class="tugas-actions">
          <button @click="toggleStatus(item)" class="btn btn-small">
            {{ item.selesai ? 'Tandai Belum' : 'Tandai Selesai' }}
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { formatStatus, validateTugas } from '../utils/tugas'

const apiUrl = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000/api'
const tugasList = ref([])
const loading = ref(true)
const submitting = ref(false)
const error = ref(null)

const form = ref({
  judul: '',
  deskripsi: '',
})

async function fetchTugas() {
  loading.value = true
  error.value = null
  try {
    const res = await fetch(`${apiUrl}/tugas`)
    if (!res.ok) throw new Error(`HTTP Error: ${res.status}`)
    tugasList.value = await res.json()
  } catch (err) {
    error.value = err.message
  } finally {
    loading.value = false
  }
}

async function tambahTugas() {
  if (!validateTugas(form.value)) return

  submitting.value = true
  try {
    const res = await fetch(`${apiUrl}/tugas`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: JSON.stringify({
        judul: form.value.judul,
        deskripsi: form.value.deskripsi,
        selesai: false,
      }),
    })

    if (!res.ok) throw new Error('Gagal menyimpan')
    const baru = await res.json()
    tugasList.value.unshift(baru)
    form.value.judul = ''
    form.value.deskripsi = ''
  } catch (err) {
    alert(err.message)
  } finally {
    submitting.value = false
  }
}

async function toggleStatus(item) {
  try {
    const res = await fetch(`${apiUrl}/tugas/${item.id}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: JSON.stringify({
        selesai: !item.selesai,
      }),
    })
    if (!res.ok) throw new Error('Gagal update')
    item.selesai = !item.selesai
  } catch (err) {
    alert(err.message)
  }
}

onMounted(() => {
  fetchTugas()
})
</script>

<style scoped>
.page-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem 1rem;
}
.top-nav {
  margin-bottom: 1rem;
}
.back-link {
  color: #2563eb;
  text-decoration: none;
  font-weight: 500;
}
.header {
  margin-bottom: 1.5rem;
}
.header h2 {
  margin: 0 0 0.25rem 0;
  color: #111827;
}
.api-info {
  margin: 0;
  color: #6b7280;
  font-size: 0.9rem;
}
code {
  background: #f3f4f6;
  padding: 0.2rem 0.4rem;
  border-radius: 4px;
}
.card {
  background: #ffffff;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 1.25rem;
  margin-bottom: 1.5rem;
}
.form-layout {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}
.form-group label {
  display: block;
  font-size: 0.85rem;
  font-weight: 600;
  margin-bottom: 0.25rem;
  color: #3730a3;
}
.form-group input {
  width: 100%;
  padding: 0.5rem 0.75rem;
  border: 1px solid #d1d5db;
  border-radius: 6px;
  font-size: 0.95rem;
  box-sizing: border-box;
}
.btn {
  padding: 0.5rem 1rem;
  border-radius: 6px;
  font-weight: 600;
  border: none;
  cursor: pointer;
}
.btn-primary {
  background: #2563eb;
  color: #ffffff;
}
.btn-small {
  background: #f3f4f6;
  color: #374151;
  border: 1px solid #d1d5db;
}
.btn-retry {
  background: #ef4444;
  color: #ffffff;
  margin-top: 0.5rem;
}
.state-box {
  padding: 1.5rem;
  text-align: center;
  border-radius: 8px;
  background: #f9fafb;
  border: 1px dashed #d1d5db;
  color: #6b7280;
}
.error-box {
  background: #fef2f2;
  border-color: #fecaca;
  color: #991b1b;
}
.tugas-list {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}
.tugas-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background: #ffffff;
  border: 1px solid #e5e7eb;
  border-radius: 8px;
}
.tugas-item.done {
  background: #f9fafb;
  opacity: 0.8;
}
.tugas-item.done h4 {
  text-decoration: line-through;
  color: #6b7280;
}
.tugas-content h4 {
  margin: 0 0 0.25rem 0;
  color: #1f2937;
}
.tugas-content p {
  margin: 0 0 0.5rem 0;
  color: #4b5563;
  font-size: 0.9rem;
}
.status-pill {
  display: inline-block;
  font-size: 0.75rem;
  font-weight: 600;
  padding: 0.2rem 0.5rem;
  border-radius: 9999px;
}
.pill-pending {
  background: #fef3c7;
  color: #92400e;
}
.pill-done {
  background: #dcfce7;
  color: #166534;
}
</style>
