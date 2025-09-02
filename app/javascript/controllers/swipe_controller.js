import { Controller } from "@hotwired/stimulus"

// data-controller="swipe"
export default class extends Controller {
  static targets = ["card"]
  static values = {
    user: Number
  }

  connect() {
    this.currentCard = null
    this.startX = 0
    console.log(this.userValue)
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
    const matchedUser = this.currentCard.dataset.userId;

    if (offsetX > 100) {
      this.currentCard.style.transform = "translateX(150%) rotate(15deg)"
      this.currentCard.style.opacity = 0
      this.#handleMatch(offsetX, matchedUser)

    } else if (offsetX < -100) {
      this.currentCard.style.transform = "translateX(-150%) rotate(-15deg)"
      this.currentCard.style.opacity = 0
      this.#handleMatch(offsetX, matchedUser)

    } else {
      this.currentCard.style.transform = ""
    }

    this.currentCard = null
  }

  dislike(event) {
    this.currentCard = event.target.offsetParent.offsetParent
    this.currentCard.style.transition = "transform 0.3s ease, opacity 0.3s ease"
    this.currentCard.style.transform = "translateX(-150%) rotate(15deg)"
    this.currentCard.style.opacity = 0
    const matchedUser = this.currentCard.dataset.userId;
    this.currentCard = null
    const offsetX = -150
    this.#handleMatch(offsetX, matchedUser)

  }

  like(event) {
    this.currentCard = event.target.offsetParent.offsetParent
    this.currentCard.style.transition = "transform 0.3s ease, opacity 0.3s ease"
    this.currentCard.style.transform = "translateX(150%) rotate(15deg)"
    this.currentCard.style.opacity = 0
    const matchedUser = this.currentCard.dataset.userId;
    this.currentCard = null
    const offsetX = 150

    this.#handleMatch(offsetX, matchedUser)
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

    #handleMatch(offsetX, matchedUserId) {
    const url = '/matches'

    const status = offsetX > 100 ? "pending" : "declined"
    const body = JSON.stringify({matcher_id: this.userValue, matched_id: matchedUserId, status: status })

    fetch(url, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,

      },
      body: body
    })
    .then(response => response.json())
    .then(data => console.log(data));
  }


}
