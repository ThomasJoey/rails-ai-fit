import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["textarea", "fileInput", "submit"]

  connect() {
    this.toggleSubmit()
  }

  update() {
    this.toggleSubmit()
  }

  toggleSubmit() {
    const textFilled = this.textareaTarget.value.trim().length > 0
    const fileFilled = this.fileInputTarget.files.length > 0

    this.submitTarget.disabled = !(textFilled || fileFilled)
  }
}
