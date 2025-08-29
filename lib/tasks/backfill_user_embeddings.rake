namespace :users do
  desc "Backfill embeddings for users missing them"
  task backfill_embeddings: :environment do
    scope = User.where(embedding: nil)

    scope.find_in_batches(batch_size: 200) do |batch|
      batch.each do |user|
        user.send(:set_embedding) # utilise ton callback privé
      end
    end
  end
end
