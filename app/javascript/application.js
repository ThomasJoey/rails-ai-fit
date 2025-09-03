// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

// Auto-scroll chat to bottom on updates
document.addEventListener("turbo:load", function () {
  const messagesContainer = document.getElementById("messages");
  if (messagesContainer) {
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
  }
});

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
  if (form.closest("#messages") || form.closest("#user_messages")) {
    // Attends que le message soit ajouté au DOM
    requestAnimationFrame(() => {
      const controllerElement = document.querySelector("[data-controller='event-button']")
      const controller = controllerElement?.__stimulusControllers?.[0]
      if (controller) {
        controller.checkIntentions()
      }
    })
  }
})
