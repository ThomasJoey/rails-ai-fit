class AddDefaultTitleToConversations < ActiveRecord::Migration[7.1]
  def change
    change_column_default :conversations, :title, "untitled"
  end
end
