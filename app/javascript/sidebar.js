// app/javascript/sidebar.js
document.addEventListener("turbo:load", () => {
  // Force sidebar collapsed and setup Bootstrap tooltips
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
  tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });

  // Optional: adjust main content margin if needed
  const containerFluid = document.querySelector(".container-fluid");
  if (containerFluid) {
    containerFluid.style.marginLeft = "70px"; // Adjust based on collapsed sidebar width
    containerFluid.style.width = "calc(100% - 70px)";
  }
});
