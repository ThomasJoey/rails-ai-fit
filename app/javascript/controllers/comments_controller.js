// app/javascript/controllers/comments_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "comments"]

  toggle(event) {
    console.log("hey")
    event.preventDefault()
    const postId = event.currentTarget.dataset.postId
    const commentsDiv = document.getElementById(`comments-${postId}`)

    if (commentsDiv) {
      commentsDiv.classList.toggle("d-none")
    }
  }
}
