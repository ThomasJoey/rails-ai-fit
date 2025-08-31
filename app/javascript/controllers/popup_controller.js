import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["popup"]

  toggle(event) {
  console.log("popup toggle", this.element.dataset.userId)
  event.stopPropagation()
  const userId = this.element.dataset.userId
  const frame = document.getElementById(`profile_popup_${userId}`)
  if (frame) {
    frame.classList.remove("hidden")
    // si besoin AJAX : frame.src = `/profiles/${userId}/card`
  }
}


  close(event) {
  console.log("popup close called")
  event.stopPropagation()
  if (this.hasPopupTarget) {
    this.popupTarget.classList.add("hidden")
    // ❌ ne pas vider ici, garde le contenu
    // this.popupTarget.innerHTML = ""
  }
}


  stop(event) {
    event.stopPropagation()
  }
}
