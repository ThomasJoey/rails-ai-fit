import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["textarea", "counter"]
  static values = { 
    maxLength: { type: Number, default: 200 },
    warningThreshold: { type: Number, default: 150 },
    dangerThreshold: { type: Number, default: 180 }
  }

  connect() {
    this.updateCounter()
  }

  updateCounter() {
    const count = this.textareaTarget.value.length
    this.counterTarget.textContent = count

    // Update color based on count
    if (count > this.dangerThresholdValue) {
      this.counterTarget.style.color = '#ef4444' // red
    } else if (count > this.warningThresholdValue) {
      this.counterTarget.style.color = '#f59e0b' // orange
    } else {
      this.counterTarget.style.color = '#a855f7' // purple
    }
  }
}