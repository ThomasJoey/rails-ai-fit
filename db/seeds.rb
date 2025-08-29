puts "Nettoyage de la base..."
Conversation.destroy_all
Event.destroy_all
User.destroy_all

puts "Création des utilisateurs..."
user1 = User.create!(
  email: "test@example.com",
  password: "password456", # Devise va générer l'encrypted_password
  first_name: "Miki",
  last_name: "Dev",
  city: "Paris ",
  sexe: "Masculin",
  preferences: "dark mode",
  role: "student",
  sports: ["Running", "Marathon", "velo"],
  age_range: "18-25",
  location: "paris, france"
)
user2 = User.create!(
  email: "test2@example.com",
  password: "password456",
  first_name: "Alice",
  last_name: "Smith",
  city: "Lyon",
  sexe: "Feminin",
  preferences: "light mode",
  role: "teacher",
  sports: ["natation", "basket", "velo"],
  age_range: "18-25",
  location: "paris, france"
)
user3 = User.create!(
  email: "test3@example.com",
  password: "password456",
  first_name: "ben",
  last_name: "thom",
  city: "Lyon",
  sexe: "Feminin",
  preferences: "light mode",
  role: "teacher",
  sports: ["kung fu", "musculation", "velo"],
  age_range: "18-25",
  location: "paris, france"
)
user4 = User.create!(
  email: "test4@example.com",
  password: "password456",
  first_name: "sophie",
  last_name: "lachaise",
  city: "Lyon",
  sexe: "Feminin",
  preferences: "light mode",
  role: "teacher",
  sports: ["escalade", "football", "velo"],
  age_range: "18-25",
  location: "paris, france"
)
user5 = User.create!(
  email: "test5@example.com",
  password: "password456",
  first_name: "clara",
  last_name: "pierre",
  city: "Lyon",
  sexe: "Feminin",
  preferences: "light mode",
  role: "teacher",
  sports: ["danse", "gym", "velo"],
  age_range: "18-25",
  location: "paris, france"
)


puts "Création des conversations..."
Conversation.create!([
 {
  title: "Apprentissage Rails",
  context: "On discute des migrations et seeds pour le bootcamp.",
  status: "active",
  user: user1,
 },
 {
title: "Projet Final",
context: "Organisation des tâches du projet collaboratif.",
status: "pending",
user: user1,
 },
 {
title: "Pause café",
context: "Discussion informelle entre les étudiants.",
status: "archived",
user: user2,
 }
])

puts "Start creation of events"
Event.create!([
 {
  title: "Tennis à 10",
  description: "Participez à une course conviviale de 5 km pour tous les niveaux, idéale pour rencontrer d'autres passionnés de course à pied.",
  starts_at: Time.zone.parse("2025-08-22 10:00"),
  ends_at: Time.zone.parse("2025-08-22 12:00"),
  location: "Parc Central, Paris",
  user: User.all.sample
 }
])

Event.create!(
  title: "HIIT Cardio",
  starts_at: Time.zone.parse("2025-08-27 08:30"),
  ends_at: Time.zone.parse("2025-08-27 09:30"),
  location: "Salle A, Studio 1",
  user: user1
)

Event.create!(
  title: "Yoga Flow",
  starts_at: Time.zone.parse("2025-08-27 10:30"),
  ends_at: Time.zone.parse("2025-08-27 11:30"),
  location: "Salle B, Studio 2",
  user: user1
)

Event.create!(
  title: "Musculation",
  starts_at: Time.zone.parse("2025-08-27 14:15"),
  ends_at: Time.zone.parse("2025-08-27 15:45"),
  location: "Salle C, Poids libres",
  user: user1
)

puts "event has been created"

puts "Seed terminée ✅"
