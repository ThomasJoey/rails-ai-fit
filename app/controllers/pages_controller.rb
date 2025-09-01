class PagesController < ApplicationController
  before_action :authenticate_user!
  
  def home
  end

  def search
    id = current_user.id

    matched_ids  = Match.where(matcher_id: id).select(:matched_id) # ceux que j’ai matchés
    matcher_ids  = Match.where(matched_id: id).select(:matcher_id) # ceux qui m’ont matché

    return unless params[:query].present?

    @users = User.where(id: matched_ids)
                 .or(User.where(id: matcher_ids)) # <- méthode AR, pas l’opérateur Ruby
                 .where.not(id: id) # par sécurité, ne me renvoie pas moi-même
                 .distinct
                 .where("first_name ILIKE :q OR last_name ILIKE :q", q: "%#{params[:query]}%")

    return unless turbo_frame_request?

    render partial: "pages/search_results", locals: { users: @users }
  end
end
