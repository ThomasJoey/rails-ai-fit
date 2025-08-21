class AddMessageToEvent < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :message, null: true, foreign_key: true
  end
end
