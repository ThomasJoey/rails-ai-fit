import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="posts"
export default class extends Controller {
  static targets = ["like"]

  connect() {
    console.log(this.likeTargets);

  }

  like(event) {
    event.currentTarget.classList.add("btn-success")
    setTimeout(() => event.currentTarget.classList.remove("btn-success"), 300)
  }
}
