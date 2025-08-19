puts "Nettoyage de la base..."
Conversation.destroy_all
User.destroy_all

puts "Création des utilisateurs..."
user = User.create!(
  email: "test@example.com",
  password: "password123", # Devise va générer l'encrypted_password
  first_name: "Miki",
  last_name: "Dev",
  city: "Paris",
  preferences: "dark mode",
  role: "student"
)

puts "Création des conversations..."
Conversation.create!([
  {
    title: "Apprentissage Rails",
    context: "On discute des migrations et seeds pour le bootcamp.",
    status: "active",
    user_id: user.id
  },
  {
    title: "Projet Final",
    context: "Organisation des tâches du projet collaboratif.",
    status: "pending",
    user_id: user.id
  },
  {
    title: "Pause café",
    context: "Discussion informelle entre les étudiants.",
    status: "archived",
    user_id: user.id
  }
])

puts "Seed terminée ✅"
