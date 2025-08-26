# app/controllers/api/geocoding_controller.rb
module Api
  class GeocodingController < ApplicationController
    def reverse
      lat = params[:lat]
      lng = params[:lng]

      result = Geocoder.search([lat, lng]).first

      if result
        render json: {
          address: result.address,
          city: result.city,
          country: result.country,
          postal_code: result.postal_code
        }
      else
        render json: { error: "Adresse non trouvée" }, status: :not_found
      end
    end

    def suggestions
      query = params[:q]
      return render json: [] if query.blank?

      results = Geocoder.search(query, params: { limit: 5 })

      suggestions = results.map do |result|
        {
          address: result.address,
          lat: result.latitude,
          lng: result.longitude,
          distance: result.distance.round(2) if result.respond_to?(:distance)
        }
      end

      render json: suggestions
    end
  end
end
