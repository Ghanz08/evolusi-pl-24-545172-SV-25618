<template>
  <div class="app-layout">
    <nav class="navbar">
      <div class="nav-brand">
        <span class="logo-dot"></span>
        Evolusi PL
      </div>
      <div class="nav-links">
        <router-link to="/">Beranda</router-link>
        <router-link to="/tugas">Data Tugas</router-link>
      </div>
    </nav>
    <main class="main-content">
      <router-view />
    </main>
  </div>
</template>

<style>
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
  background-color: #f8fafc;
  color: #0f172a;
}
.app-layout {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 2rem;
  background: #ffffff;
  border-bottom: 1px solid #e2e8f0;
}
.nav-brand {
  font-weight: 700;
  font-size: 1.1rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}
.logo-dot {
  width: 10px;
  height: 10px;
  background: #2563eb;
  border-radius: 50%;
  display: inline-block;
}
.nav-links {
  display: flex;
  gap: 1.5rem;
}
.nav-links a {
  text-decoration: none;
  color: #64748b;
  font-weight: 500;
  font-size: 0.95rem;
  transition: color 0.2s;
}
.nav-links a:hover,
.nav-links a.router-link-active {
  color: #2563eb;
}
.main-content {
  flex: 1;
}
</style>
