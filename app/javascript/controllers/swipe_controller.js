import { Controller } from "@hotwired/stimulus"

// data-controller="swipe"
export default class extends Controller {
  static targets = ["card"]

  connect() {
    this.currentCard = null
    this.startX = 0
  }

  startDrag(event) {
    this.currentCard = event.currentTarget
    this.startX = this.getX(event)
    this.currentCard.style.transition = "none"
  }

  drag(event) {
    if (!this.currentCard) return
    const offsetX = this.getX(event) - this.startX
    this.currentCard.style.transform = `translateX(${offsetX}px) rotate(${offsetX * 0.05}deg)`
  }

  endDrag(event) {
    if (!this.currentCard) return
    const offsetX = this.getX(event) - this.startX
    this.currentCard.style.transition = "transform 0.3s ease, opacity 0.3s ease"

    if (offsetX > 100) {
      this.currentCard.style.transform = "translateX(150%) rotate(15deg)"
      this.currentCard.style.opacity = 0
    } else if (offsetX < -100) {
      this.currentCard.style.transform = "translateX(-150%) rotate(-15deg)"
      this.currentCard.style.opacity = 0
    } else {
      this.currentCard.style.transform = ""
    }

    this.currentCard = null
  }

  // Gestion souris + tactile
  getX(event) {
    if (event.type.startsWith("mouse")) {
      return event.clientX
    } else if (event.type === "touchend") {
      return event.changedTouches[0].clientX
    } else {
      return event.touches[0].clientX
    }
  }

}
