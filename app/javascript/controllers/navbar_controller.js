// app/javascript/controllers/navbar_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["item"]

  connect() {
    // Optionnel : tu pourrais mettre un log pour debug
    // console.log("Navbar controller connecté")
  }

  activate(event) {
    event.preventDefault()

    this.itemTargets.forEach((el) => el.classList.remove("active"))
    event.currentTarget.classList.add("active")
  }
}
