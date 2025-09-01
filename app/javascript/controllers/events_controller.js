// app/javascript/controllers/events_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card", "searchInput", "filter", "popup"]

  search() {
    const query = this.searchInputTarget.value.toLowerCase()
    this.cardTargets.forEach(card => {
      const text = card.innerText.toLowerCase()
      card.style.display = text.includes(query) ? "" : "none"
    })
  }

  filter(event) {
    const selectedSport = event.currentTarget.dataset.sport
    this.filterTargets.forEach(btn => btn.classList.remove("active"))
    event.currentTarget.classList.add("active")

    this.cardTargets.forEach(card => {
      const sport = card.dataset.sport
      card.style.display = (sport === selectedSport) ? "" : "none"
    })
  }

  register(event) {
    event.preventDefault()
    this.popupTarget.classList.remove("hidden")
  }

  closePopup() {
    this.popupTarget.classList.add("hidden")
  }
}
