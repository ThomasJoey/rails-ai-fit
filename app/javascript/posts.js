document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".like-btn").forEach((btn) => {
    btn.addEventListener("click", (e) => {
      // Juste un petit effet de feedback visuel
      btn.classList.add("btn-success")
      setTimeout(() => btn.classList.remove("btn-success"), 300)
    })
  })
})
