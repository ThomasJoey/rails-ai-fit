class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :starts_at
      t.string :ends_at
      t.string :location
      t.string :visibility
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
