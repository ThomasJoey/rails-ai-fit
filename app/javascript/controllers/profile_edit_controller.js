import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["avatarInput", "avatarPreview", "locationInput", "detectLocationBtn", "sportCounter"]
  static values = { maxSports: { type: Number, default: 3 } }

  connect() {
    this.setupAvatarPreview()
    this.setupGeolocation()
    this.setupSportsCounter()
  }

  setupAvatarPreview() {
    if (this.hasAvatarInputTarget) {
      this.avatarInputTarget.addEventListener("change", this.handleAvatarChange.bind(this))
    }
  }

  setupGeolocation() {
    if (this.hasDetectLocationBtnTarget && this.hasLocationInputTarget) {
      this.detectLocationBtnTarget.addEventListener("click", this.detectLocation.bind(this))
    }
  }

  handleAvatarChange(event) {
    const file = event.target.files[0]
    if (file && this.hasAvatarPreviewTarget) {
      const reader = new FileReader()
      reader.onload = (e) => {
        this.avatarPreviewTarget.src = e.target.result
      }
      reader.readAsDataURL(file)
    }
  }

  detectLocation() {
    if (!navigator.geolocation) {
      alert("La géolocalisation n'est pas supportée par votre navigateur")
      return
    }

    this.setLoadingState(true)

    navigator.geolocation.getCurrentPosition(
      (position) => this.handleLocationSuccess(position),
      (error) => this.handleLocationError(error),
      {
        enableHighAccuracy: true,
        timeout: 10000,
        maximumAge: 60000
      }
    )
  }

  handleLocationSuccess(position) {
    const lat = position.coords.latitude
    const lng = position.coords.longitude

    fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lng}`)
      .then(response => response.json())
      .then(data => {
        this.locationInputTarget.value = data.display_name || `${lat.toFixed(6)}, ${lng.toFixed(6)}`
      })
      .catch(() => {
        this.locationInputTarget.value = `${lat.toFixed(6)}, ${lng.toFixed(6)}`
      })
      .finally(() => {
        this.setLoadingState(false)
      })
  }

  handleLocationError(error) {
    this.setLoadingState(false)
    
    let message = "Erreur lors de la détection de votre position"
    switch(error.code) {
      case error.PERMISSION_DENIED:
        message = "Permission de géolocalisation refusée"
        break
      case error.POSITION_UNAVAILABLE:
        message = "Position non disponible"
        break
      case error.TIMEOUT:
        message = "Délai d'attente dépassé"
        break
    }
    alert(message)
  }

  setLoadingState(loading) {
    if (this.hasDetectLocationBtnTarget) {
      this.detectLocationBtnTarget.disabled = loading
      this.detectLocationBtnTarget.innerHTML = loading 
        ? '<i class="fas fa-spinner fa-spin"></i>'
        : '<i class="fas fa-crosshairs"></i>'
    }
  }

  setupSportsCounter() {
    this.sportCheckboxes = this.element.querySelectorAll(".sport-selector")
    if (this.sportCheckboxes.length > 0) {
      this.updateSportCounter()
      this.sportCheckboxes.forEach(checkbox => {
        checkbox.addEventListener("change", this.handleSportChange.bind(this))
      })
    }
  }

  handleSportChange(event) {
    const checkedBoxes = this.element.querySelectorAll(".sport-selector:checked")
    
    if (checkedBoxes.length > this.maxSportsValue) {
      event.target.checked = false
      alert(`Vous ne pouvez sélectionner que ${this.maxSportsValue} sports maximum.`)
    }

    this.updateSportCounter()
  }

  updateSportCounter() {
    if (this.hasSportCounterTarget) {
      const checkedBoxes = this.element.querySelectorAll(".sport-selector:checked")
      const count = checkedBoxes.length

      this.sportCounterTarget.textContent = count

      if (count >= this.maxSportsValue) {
        this.sportCounterTarget.classList.add("max-reached")
      } else {
        this.sportCounterTarget.classList.remove("max-reached")
      }
    }
  }
}