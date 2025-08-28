class MatchesController < ApplicationController
  def index
    @user = current_user

    # 1) Sports du user, nettoyés
    list = Array(@user.sports).map { |s| s.to_s.strip }.reject(&:blank?)
    if list.blank?
      @potential_matches = User.none
      flash.now[:alert] = "Renseigne au moins un sport dans ton profil."
      return
    end

    # 2) Candidats SQL stricts
    base = User.where.not(id: @user.id).geocoded
    base = base.where(age_range: @user.age_range) if @user.age_range.present?
    # ta colonne est un varchar[] -> caster la partie droite en varchar[]
    base = base.where("sports && ARRAY[?]::varchar[]", list)

    # 3) Embedding de requête (cohérent avec User#embedding_text)
    query_text = "Sports: #{list.join(', ')}"
    query_vec  = RubyLLM.embed(query_text)&.vectors
    if query_vec.blank?
      @potential_matches = User.none
      flash.now[:alert] = "Impossible de générer l'embedding de recherche."
      return
    end

    # 4) Classement sémantique (pgvector) — ton index est vector_cosine_ops
    scope = base.where.not(embedding: nil)
                .nearest_neighbors(:embedding, query_vec, distance: "cosine")

    # 5) Filtre rayon 10 km SANS casser l'ordre (corrigé)
    if @user.latitude.present? && @user.longitude.present?
      # Option 1 (sous-requête propre)
      scope = scope.where(id: @user.nearbys(10).reselect(:id))
      # Option 2 (si tu préfères, remplace la ligne au-dessus par:)
      # scope = scope.where(id: @user.nearbys(10).pluck(:id))
    else
      flash.now[:alert] = "Ton emplacement n'est pas défini — filtrage par distance ignoré."
    end

    # 6) Limite finale
    @potential_matches = scope.limit(10)
  end
end
