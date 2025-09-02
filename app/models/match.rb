class Match < ApplicationRecord
  belongs_to :matcher, class_name: "User"
  belongs_to :matched, class_name: "User"

  # --> AJOUT
  after_update_commit :broadcast_its_a_match, if: :just_accepted?

  private

  # On ne déclenche que si le statut vient de changer ET vaut "accepted"
  def just_accepted?
    saved_change_to_status? && status == "accepted"
  end

  # Diffuse UNIQUEMENT vers l'utilisateur qui a le matched_id
  def broadcast_its_a_match
    Turbo::StreamsChannel.broadcast_prepend_later_to(
      "user_#{matched_id}",                    # stream du user "matched"
      target: "match-flash-stream",            # <div id="match-flash-stream">
      partial: "matches/its_a_match",          # le partial à rendre
      locals: { match: self }                  # données pour le partial
    )
  end
end
