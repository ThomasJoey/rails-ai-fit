// app/javascript/controllers/navbar_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["item"]

  activate(event) {
    this.itemTargets.forEach((el) => el.classList.remove("active"))
    event.currentTarget.classList.add("active")
  }
}
