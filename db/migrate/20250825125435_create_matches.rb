class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.references :matcher, null: false, foreign_key: { to_table: :users }
      t.references :matched, null: false, foreign_key: { to_table: :users }
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
