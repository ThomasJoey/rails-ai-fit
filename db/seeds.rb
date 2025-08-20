puts "Nettoyage de la base..."
Conversation.destroy_all
Event.destroy_all
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
    user: user
  },
  {
    title: "Projet Final",
    context: "Organisation des tâches du projet collaboratif.",
    status: "pending",
    user: user
  },
  {
    title: "Pause café",
    context: "Discussion informelle entre les étudiants.",
    status: "archived",
    user: user
  }
])

puts "Start creation of events"

Event.create!(
  title: "Tennis à 10"
)

puts "event has been created"

puts "Seed terminée ✅"
