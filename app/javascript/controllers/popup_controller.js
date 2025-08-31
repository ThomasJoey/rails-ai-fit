import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["popup"]

  toggle(event) {
    event.stopPropagation()
    this.popupTarget.classList.toggle("hidden")
  }

  close(event) {
    event.stopPropagation()
    this.popupTarget.classList.add("hidden")
  }

  stop(event) {
    event.stopPropagation()
  }
}

