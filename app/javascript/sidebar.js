// document.addEventListener("DOMContentLoaded", () => {
document.addEventListener("turbo:load", () => {
    const sidebar = document.getElementById("sidebar");
    const btnOpen = document.getElementById("btn-open");
    const btnClose = document.getElementById("btn-close");
    const navTitles = document.querySelectorAll(".nav-item-title");
    const containerFluid = document.querySelector(".container-fluid");
  
    // Ensure sidebar is collapsed on load
    sidebar.classList.add("collapsed");
    btnOpen.style.display = "inline-block";
    btnClose.style.display = "none";
    navTitles.forEach((title) => (title.style.opacity = "0"));
  
    // Expand Sidebar
    btnOpen.addEventListener("click", () => {
      sidebar.classList.remove("collapsed");
      btnOpen.style.display = "none";
      btnClose.style.display = "inline-block";
      containerFluid.style.marginLeft = "215px";
      containerFluid.style.width = "82%";
      navTitles.forEach((title) => (title.style.opacity = "1"));
    });
  
    // Collapse Sidebar
    btnClose.addEventListener("click", () => {
      sidebar.classList.add("collapsed");
      btnClose.style.display = "none";
      btnOpen.style.display = "inline-block";
      containerFluid.style.marginLeft = "25px";
      containerFluid.style.width = "95%";
      navTitles.forEach((title) => (title.style.opacity = "0"));
    });
  
  });