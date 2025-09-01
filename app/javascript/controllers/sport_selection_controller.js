import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["nextBtn", "counterText", "selectedCount"]

  connect() {
    this.maxSelections = 3
    this.updateUI()
  }

  selectSport(event) {
    const sportItem = event.currentTarget
    const checkbox = sportItem.querySelector('input[type="checkbox"]')

    if (checkbox.checked) {
      // Décocher le sport
      checkbox.checked = false
    } else {
      // Vérifier si on peut encore sélectionner
      const selectedCount = this.getSelectedCount()
      if (selectedCount < this.maxSelections) {
        checkbox.checked = true
      }
    }

    this.updateUI()
  }

  getSelectedCount() {
    return this.element.querySelectorAll('input[type="checkbox"]:checked').length
  }

  updateUI() {
    const selectedCount = this.getSelectedCount()

    // Mettre à jour le compteur
    if (this.hasSelectedCountTarget) {
      this.selectedCountTarget.textContent = selectedCount
    }

    // Mettre à jour le texte du compteur
    if (this.hasCounterTextTarget) {
      if (selectedCount === 0) {
        this.counterTextTarget.textContent = "Sélectionne tes 3 sports préférés"
      } else if (selectedCount < this.maxSelections) {
        this.counterTextTarget.textContent = `Sélectionne ${this.maxSelections - selectedCount} sport${this.maxSelections - selectedCount > 1 ? 's' : ''} de plus`
      }
    }

    // Activer/désactiver le bouton suivant
    if (this.hasNextBtnTarget) {
      this.nextBtnTarget.disabled = selectedCount !== this.maxSelections

      // Changer le style du bouton selon l'état
      if (selectedCount === this.maxSelections) {
        this.nextBtnTarget.style.opacity = '1'
        this.nextBtnTarget.style.cursor = 'pointer'
      } else {
        this.nextBtnTarget.style.opacity = '0.5'
        this.nextBtnTarget.style.cursor = 'not-allowed'
      }
    }

    // Mettre à jour les styles des sports non sélectionnables
    const sportItems = this.element.querySelectorAll('.sport-item')
    sportItems.forEach(item => {
      const checkbox = item.querySelector('input[type="checkbox"]')
      const label = item.querySelector('.sport-label')

      if (!checkbox.checked && selectedCount >= this.maxSelections) {
        label.style.opacity = '0.5'
        label.style.cursor = 'not-allowed'
      } else {
        label.style.opacity = '1'
        label.style.cursor = 'pointer'
      }
    })
  }
}
