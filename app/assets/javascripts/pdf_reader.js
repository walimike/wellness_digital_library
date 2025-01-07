document.addEventListener("DOMContentLoaded", () => {
  let pdfDoc = null;
  let currentPage = 1;
  const canvas = document.getElementById("pdf-canvas");
  const ctx = canvas.getContext("2d");

  // Load PDF when modal opens
  const readModal = document.getElementById("readModal");
  readModal.addEventListener("show.bs.modal", (event) => {
    const pdfPath = event.relatedTarget.getAttribute("data-pdf-path");
    if (pdfPath) {
      loadPDF(pdfPath);
    }
  });

  // Load PDF using PDF.js
  async function loadPDF(url) {
    pdfDoc = await pdfjsLib.getDocument(url).promise;
    renderPage(currentPage);
  }

  // Render a specific page
  async function renderPage(pageNum) {
    const page = await pdfDoc.getPage(pageNum);
    const viewport = page.getViewport({ scale: 1.5 });
    canvas.height = viewport.height;
    canvas.width = viewport.width;

    const renderContext = {
      canvasContext: ctx,
      viewport: viewport,
    };

    page.render(renderContext);
  }

  // Event listeners for Next and Previous buttons
  document.getElementById("next-btn").addEventListener("click", () => {
    if (currentPage < pdfDoc.numPages) {
      currentPage++;
      renderPage(currentPage);
    }
  });

  document.getElementById("prev-btn").addEventListener("click", () => {
    if (currentPage > 1) {
      currentPage--;
      renderPage(currentPage);
    }
  });
});
