import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["popup"]

  toggle(event) {

  console.log("popup toggle", event.currentTarget.dataset.userId)
  event.stopPropagation()
  const userId = event.currentTarget.dataset.userId
  this.frame = document.getElementById(`profile_popup_${userId}`)
  if (this.frame) {
    this.frame.classList.remove("hidden")
    // si besoin AJAX : frame.src = `/profiles/${userId}/card`
  }
}


  close(event) {
  console.log("popup close called")
  event.stopPropagation()
  console.log(this.frame);


  if (this.frame) {
    this.frame.classList.add("hidden")
    // ❌ ne pas vider ici, garde le contenu
    // this.popupTarget.innerHTML = ""
  }
}


  stop(event) {
    event.stopPropagation()
  }
}
