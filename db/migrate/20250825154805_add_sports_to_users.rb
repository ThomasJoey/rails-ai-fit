class AddSportsToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :sport, :string
    add_column :users, :sports, :string, array: true, default: []
    add_index :users, :sports, using: :gin
  end
end
