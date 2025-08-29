class MatchesController < ApplicationController
  def index
    @user = current_user

    # 1) Sports du user, nettoyés
    lst = @user.sports
    if lst.blank?
      flash.now[:alert] = "Renseigne au moins un sport dans ton profil."
      return
    end

    # 2) Candidats SQL stricts
    base = User.where.not(id: @user.id).geocoded
    base = base.where(age_range: @user.age_range) if @user.age_range.present?
    # ta colonne est un varchar[] -> caster la partie droite en varchar[]
    base = base.where("sports && ARRAY[?]::varchar[]", lst)

    # 5) Filtre rayon 10 km SANS casser l'ordre (corrigé)
    if @user.latitude.present? && @user.longitude.present?
      # Option 1 (sous-requête propre)
      scope = base.where(id: @user.nearbys(1000).map(&:id))
    else
      flash.now[:alert] = "Ton emplacement n'est pas défini — filtrage par distance ignoré."
    end

    # 6) Limite finale
    @potential_matches = scope.limit(10)
  end
end
