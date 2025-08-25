class AddNewColumToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :age, :integer
    add_column :users, :sport, :string
    add_column :users, :sexe, :string

  end
end
