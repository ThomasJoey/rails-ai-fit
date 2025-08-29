// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import "./comments"
import "./posts"
import "./navbar"
import "./new_post"

// Auto-scroll chat to bottom on updates
function scrollMessagesToBottom() {
  const container = document.getElementById("messages")
  if (container) {
    container.scrollTo({ top: container.scrollHeight, behavior: "smooth" })
  }
}

document.addEventListener("turbo:load", scrollMessagesToBottom)

document.addEventListener("turbo:frame-load", scrollMessagesToBottom)

document.addEventListener("turbo:before-stream-render", (event) => {
  const action = event.target?.getAttribute?.("action")
  if (action === "append" || action === "update" || action === "replace") {
    // defer scroll to after render
    requestAnimationFrame(() => setTimeout(scrollMessagesToBottom, 0))
  }
})

// Ensure staying at bottom after submitting the message form
document.addEventListener("submit", (e) => {
  const form = e.target
  if (form && form.closest("#messages")) {
    // If a form lives inside the messages container, keep bottom after submit
    requestAnimationFrame(() => setTimeout(scrollMessagesToBottom, 0))
  }
})
