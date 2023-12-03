<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div class="sidebar" id="sidebar">
  <div class="brand">
    <a class="navbar-brand">Admin</a>
  </div>
  <div class="nav-links">
    <ul class="navbar-nav">
      <li class="nav-item"><a class="nav-link" href="/"><i class="fas fa-home"></i><span>Home</span></a></li>
      <li class="nav-item"><a class="nav-link" href="/admin/books"><i class="fas fa-book"></i><span>Books</span></a></li>
      <li class="nav-item"><a class="nav-link" href="/admin/authors"><i class="fas fa-user"></i><span>Author</span></a></li>
      <li class="nav-item"><a class="nav-link" href="/admin/publishers"><i class="fas fa-building"></i><span>Publisher</span></a></li>
      <li class="nav-item"><a class="nav-link" href="/admin/categories"><i class="fas fa-list"></i><span>Category</span></a></li>
      <li class="nav-item"><a class="nav-link" href="/admin/bills"><i class="fas fa-money-bill"></i><span>Bills</span></a></li>
      <li class="nav-item"><a class="nav-link" href="/admin/users"><i class="fas fa-users"></i><span>Users</span></a></li>
      <li class="nav-item"><a class="nav-link" href="/logout"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a></li>
    </ul>
  </div>
  <div class="toggle-btn" onclick="toggleSidebar()">
    <i class="fas fa-chevron-left"></i>
  </div>
</div>