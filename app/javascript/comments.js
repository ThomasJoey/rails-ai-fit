document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".comment-toggle").forEach((btn) => {
    btn.addEventListener("click", () => {
      const postId = btn.dataset.postId
      const commentsDiv = document.getElementById(`comments-${postId}`)
      if (commentsDiv) {
        commentsDiv.classList.toggle("d-none")
      }
    })
  })
})

