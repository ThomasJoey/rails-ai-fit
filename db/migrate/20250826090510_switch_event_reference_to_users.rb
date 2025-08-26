class SwitchEventReferenceToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_reference :events, :message, foreign_key: true
    add_reference :events, :user, foreign_key: true
    add_reference :messages, :user, foreign_key: true
  end
end
