import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["textarea", "fileInput", "submit", "imagePreview"]

  connect() {
    this.update()
  }

  update() {
    const hasContent = this.textareaTarget.value.trim().length > 0
    const hasImage = this.hasImageSelected()
    
    this.submitTarget.disabled = !(hasContent || hasImage)
  }

  handleImageSelect(event) {
    const file = event.target.files[0]
    if (file && file.type.startsWith('image/')) {
      this.showImagePreview(file)
    }
    this.update()
  }

  showImagePreview(file) {
    const reader = new FileReader()
    reader.onload = (e) => {
      this.imagePreviewTarget.innerHTML = `
        <div class="image-preview-container">
          <img src="${e.target.result}" alt="Aperçu" class="image-preview">
          <button type="button" class="remove-image-btn" data-action="click->post-form#removeImage">
            <i class="fa-solid fa-times"></i>
          </button>
        </div>
      `
      this.imagePreviewTarget.style.display = 'block'
    }
    reader.readAsDataURL(file)
  }

  removeImage() {
    this.imagePreviewTarget.innerHTML = ''
    this.imagePreviewTarget.style.display = 'none'
    // Réinitialiser tous les inputs de fichier
    this.fileInputTargets.forEach(input => input.value = '')
    this.update()
  }

  hasImageSelected() {
    return this.fileInputTargets.some(input => input.files.length > 0)
  }
}









