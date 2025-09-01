// app/javascript/controllers/location_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="location"
export default class extends Controller {
  static targets = ["input", "button"]

  connect() {
    // rien à faire au chargement, Stimulus gère l’attachement
  }

  detect(event) {
    event.preventDefault()

    if (!navigator.geolocation) {
      alert("La géolocalisation n'est pas supportée par votre navigateur")
      return
    }

    this.showLoading()

    navigator.geolocation.getCurrentPosition(
      async (position) => {
        const lat = position.coords.latitude
        const lng = position.coords.longitude

        try {
          const response = await fetch(`/api/reverse_geocode?lat=${lat}&lng=${lng}`)
          const data = await response.json()

          if (data.address) {
            this.inputTarget.value = data.address

            // Afficher sur la carte si une fonction globale existe
            if (window.showLocationOnMap) {
              window.showLocationOnMap(lat, lng)
            }
          }
        } catch (error) {
          console.error("Erreur de géocodage:", error)
          alert("Impossible de déterminer votre adresse")
        }

        this.resetButton()
      },
      () => {
        alert("Impossible d'obtenir votre position. Vérifiez vos paramètres.")
        this.resetButton()
      }
    )
  }

  showLoading() {
    this.buttonTarget.innerHTML = '<span class="spinner-border spinner-border-sm"></span>'
    this.buttonTarget.disabled = true
  }

  resetButton() {
    this.buttonTarget.innerHTML = '<i class="fas fa-crosshairs"></i>'
    this.buttonTarget.disabled = false
  }
}
