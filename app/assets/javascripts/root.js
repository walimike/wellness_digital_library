document.addEventListener('DOMContentLoaded', function() {
  // Mobile menu toggle
  const toggle = document.querySelector('.mobile-menu-toggle');
  const navLinks = document.querySelector('.nav-links');
  toggle.addEventListener('click', () => {
    navLinks.classList.toggle('show');
  });

  // Carousel logic
  const items = document.querySelectorAll('.carousel-item');
  const nextBtn = document.querySelector('.carousel-control.next');
  const prevBtn = document.querySelector('.carousel-control.prev');
  let current = 0;

  function showItem(index) {
    items.forEach((item, i) => {
      item.classList.toggle('active', i === index);
    });
  }

  nextBtn.addEventListener('click', () => {
    current = (current + 1) % items.length;
    showItem(current);
  });

  prevBtn.addEventListener('click', () => {
    current = (current - 1 + items.length) % items.length;
    showItem(current);
  });

  // Optional: auto-advance carousel every N seconds
  setInterval(() => {
    current = (current + 1) % items.length;
    showItem(current);
  }, 5000);
});
