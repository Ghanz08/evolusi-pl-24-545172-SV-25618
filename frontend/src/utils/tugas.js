/**
 * Helper untuk format status & validasi tugas frontend
 */
export function formatStatus(selesai) {
  return selesai ? 'Selesai' : 'Belum Selesai'
}

export function validateTugas(tugas) {
  if (!tugas || typeof tugas.judul !== 'string') return false
  return tugas.judul.trim().length > 0
}

export function filterTugasByStatus(list, filter) {
  if (!Array.isArray(list)) return []
  if (filter === 'selesai') return list.filter(item => item.selesai === true)
  if (filter === 'belum') return list.filter(item => item.selesai === false)
  return list
}
