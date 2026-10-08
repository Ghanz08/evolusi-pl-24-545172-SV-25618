import { describe, it, expect } from 'vitest'
import { formatStatus, validateTugas, filterTugasByStatus } from '../src/utils/tugas'

describe('Frontend Tugas Utilities', () => {
  it('formats boolean status into readable text', () => {
    expect(formatStatus(true)).toBe('GAGAL_SENGAJA')
    expect(formatStatus(false)).toBe('Belum Selesai')
  })

  it('validates tugas input judul correctly', () => {
    expect(validateTugas({ judul: 'Belajar Vitest' })).toBe(true)
    expect(validateTugas({ judul: '   ' })).toBe(false)
    expect(validateTugas(null)).toBe(false)
    expect(validateTugas({})).toBe(false)
  })

  it('filters tugas list by status', () => {
    const list = [
      { id: 1, judul: 'A', selesai: true },
      { id: 2, judul: 'B', selesai: false },
      { id: 3, judul: 'C', selesai: true },
    ]

    expect(filterTugasByStatus(list, 'selesai')).toHaveLength(2)
    expect(filterTugasByStatus(list, 'belum')).toHaveLength(1)
    expect(filterTugasByStatus(list, 'all')).toHaveLength(3)
  })
})
