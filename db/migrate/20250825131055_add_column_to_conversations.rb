class AddColumnToConversations < ActiveRecord::Migration[7.1]
  def change
    add_reference :conversations, :second_user, null: true, foreign_key: { to_table: :users }
  end
end
