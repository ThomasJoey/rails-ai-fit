class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.string :title
      t.text :context
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
