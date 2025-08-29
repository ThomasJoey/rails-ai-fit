class AddEmbeddingToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :embedding, :vector, limit: 1536
  end
end
