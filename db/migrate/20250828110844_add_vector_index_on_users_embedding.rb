class AddVectorIndexOnUsersEmbedding < ActiveRecord::Migration[7.1]
  def up
    enable_extension "vector" unless extension_enabled?("vector")

    # IMPORTANT : construire l’index après avoir rempli quelques embeddings,
    # sinon Postgres se plaint qu'ivfflat n’aime pas les tables vides.
    execute <<~SQL
      CREATE INDEX IF NOT EXISTS index_users_on_embedding_ivfflat
      ON users
      USING ivfflat (embedding vector_cosine_ops)
      WITH (lists = 100);
    SQL
  end

  def down
    execute "DROP INDEX IF EXISTS index_users_on_embedding_ivfflat"
  end
end
