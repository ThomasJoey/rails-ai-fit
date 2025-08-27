document.addEventListener("DOMContentLoaded", () => {
  const navItems = document.querySelectorAll(".mobile-navbar .nav-item");

  navItems.forEach(item => {
    item.addEventListener("click", () => {
      navItems.forEach(i => i.classList.remove("active"));
      item.classList.add("active");
    });
  });
});
