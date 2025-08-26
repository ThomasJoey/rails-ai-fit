// app/javascript/location.js
document.addEventListener('turbo:load', () => {
  const locationInput = document.getElementById('location-input');
  const detectBtn = document.getElementById('detect-location');

  if (detectBtn) {
    detectBtn.addEventListener('click', () => {
      if (navigator.geolocation) {
        detectBtn.innerHTML = '<span class="spinner-border spinner-border-sm"></span>';
        detectBtn.disabled = true;

        navigator.geolocation.getCurrentPosition(
          async (position) => {
            const lat = position.coords.latitude;
            const lng = position.coords.longitude;

            // Reverse geocoding pour obtenir l'adresse
            try {
              const response = await fetch(`/api/reverse_geocode?lat=${lat}&lng=${lng}`);
              const data = await response.json();

              if (data.address) {
                locationInput.value = data.address;

                // Afficher sur la carte si vous avez intégré une carte
                if (window.showLocationOnMap) {
                  window.showLocationOnMap(lat, lng);
                }
              }
            } catch (error) {
              console.error('Erreur de géocodage:', error);
              alert('Impossible de déterminer votre adresse');
            }

            detectBtn.innerHTML = '<i class="fas fa-crosshairs"></i>';
            detectBtn.disabled = false;
          },
          (error) => {
            alert('Impossible d\'obtenir votre position. Vérifiez vos paramètres.');
            detectBtn.innerHTML = '<i class="fas fa-crosshairs"></i>';
            detectBtn.disabled = false;
          }
        );
      } else {
        alert('La géolocalisation n\'est pas supportée par votre navigateur');
      }
    });
  }
});
