class CreateMessageUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :message_users do |t|
    t.references :conversation
    t.text :content
    t.references :sender, null: false, foreign_key: { to_table: :users }
    t.timestamps
    end
  end
end
