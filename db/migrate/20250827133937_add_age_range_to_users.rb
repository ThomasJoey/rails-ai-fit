class AddAgeRangeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :age_range, :string
  end
end
