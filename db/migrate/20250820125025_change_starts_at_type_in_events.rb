class ChangeStartsAtTypeInEvents < ActiveRecord::Migration[7.1]
  def up
    execute <<~SQL
      ALTER TABLE events
      ALTER COLUMN starts_at TYPE timestamp(6) without time zone
      USING starts_at::timestamp(6) without time zone;
    SQL
  end

  def down
    # Reviens au type d'origine (par ex. string)
    change_column :events, :starts_at, :string
  end
end

