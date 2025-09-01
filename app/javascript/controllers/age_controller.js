import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "slider"]

  connect() {
    this.updateDisplay()
    this.updateGenerationLabel()
  }

  updateDisplay() {
    const age = parseInt(this.sliderTarget.value)
    this.displayTarget.textContent = age
    this.updateGenerationLabel()
  }

  updateGenerationLabel() {
    const age = parseInt(this.sliderTarget.value)
    const labels = this.element.querySelectorAll('.generation-label')

    // Remove active class from all labels
    labels.forEach(label => label.classList.remove('active'))

    // Add active class based on age range
    let activeLabel = null
    if (age >= 18 && age <= 27) {
      activeLabel = this.element.querySelector('[data-range="18-27"]')
    } else if (age >= 28 && age <= 43) {
      activeLabel = this.element.querySelector('[data-range="28-43"]')
    } else if (age >= 44 && age <= 59) {
      activeLabel = this.element.querySelector('[data-range="44-59"]')
    } else if (age >= 60 && age <= 99) {
      activeLabel = this.element.querySelector('[data-range="60-99"]')
    }

    if (activeLabel) {
      activeLabel.classList.add('active')
    }
  }
}
