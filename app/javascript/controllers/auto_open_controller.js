import { Controller } from "@hotwired/stimulus"

// data-controller="auto-open"
export default class extends Controller {
  connect() {
    console.log("hey modal")
    const modal = new bootstrap.Modal(this.element)
    modal.show()
  }
}
