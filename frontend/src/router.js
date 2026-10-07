import { createRouter, createWebHistory } from 'vue-router'
import HomeView from './views/HomeView.vue'
import TugasView from './views/TugasView.vue'

const routes = [
  { path: '/', name: 'Home', component: HomeView },
  { path: '/tugas', name: 'Tugas', component: TugasView },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
