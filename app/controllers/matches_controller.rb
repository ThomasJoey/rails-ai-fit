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
      scope = base.where(id: @user.nearbys(10).map(&:id))
    else
      flash.now[:alert] = "Ton emplacement n'est pas défini — filtrage par distance ignoré."
      scope = base # fallback to unfiltered base
    end

    # 6) Limite finale
    @potential_matches = scope - current_user.users_with_a_declined_or_accepted_match
  end



  def create
    user = current_user
    other = User.find(params[:matched_id])
    decision = params[:status]


    # 1) Enregistrer/mettre à jour MON vote A->B
    match = Match.where(matcher_id: current_user.id, matched_id: other.id).or(Match.where(matcher_id: other.id, matched_id: current_user.id)).first
    if match
      match.status == "pending" && decision == "pending" ? match.update(status: "accepted") : match.update(status: "declined")
    else
      match = Match.new(matcher: current_user, matched: other, status: decision)
    end
    match.save!

    render json: { ok: true, id: match.id }, status: :created
  end

  private


  def match_params
    params.require(:match).permit(:matched_id, :matcher_id, :status)
  end
end
