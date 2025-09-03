// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

// Auto-scroll chat to bottom on updates
function scrollMessagesToBottom() {
  const container = document.getElementById("messages")
  if (container) {
    container.scrollTop = container.scrollHeight
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
