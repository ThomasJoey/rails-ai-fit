class ChangeDefaultStatusInConversations < ActiveRecord::Migration[7.1]
  def change
      change_column_default :conversations, :status, "active"
  end
end
