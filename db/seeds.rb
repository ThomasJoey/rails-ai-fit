puts "Nettoyage de la base..."
Conversation.destroy_all
Event.destroy_all
User.destroy_all

puts "Création des utilisateurs..."
user1 = User.create!(
  email: "test@example.com",
  password: "password456",
  first_name: "Miki",
  last_name: "Dev",
  city: "Paris",
  sexe: "Masculin",
  preferences: "dark mode",
  role: "student",
  sports: ["Running", "Marathon", "velo"],
  age_range: "18-25",
  latitude: 48.8600,
  longitude: 2.3490,
)

user1.avatar.attach(
  io: File.open(Rails.root.join("db/images/mikiphoto.jpg")),
  filename: "mikiphoto.jpg",
  content_type: "image/jpg"
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
  latitude: 48.8600,
  longitude: 2.3490,
)

user2.avatar.attach(
  io: File.open(Rails.root.join("db/images/alice.jpg")),
  filename: "alice.jpg",
  content_type: "image/jpg"
)

user3 = User.create!(
  email: "test3@example.com",
  password: "password456",
  first_name: "Ben",
  last_name: "Thom",
  city: "Lyon",
  sexe: "Masculin",
  preferences: "light mode",
  role: "teacher",
  sports: ["kung fu", "musculation", "velo"],
  age_range: "18-25",
  latitude: 48.8600,
  longitude: 2.3490,
)

user3.avatar.attach(
  io: File.open(Rails.root.join("db/images/ben.jpg")),
  filename: "ben.jpg",
  content_type: "image/jpg"
)

user4 = User.create!(
  email: "test4@example.com",
  password: "password456",
  first_name: "Sophie",
  last_name: "Lachaise",
  city: "Lyon",
  sexe: "Feminin",
  preferences: "light mode",
  role: "teacher",
  sports: ["escalade", "football", "velo"],
  age_range: "18-25",
  latitude: 48.8600,
  longitude: 2.3490,
)

user4.avatar.attach(
  io: File.open(Rails.root.join("db/images/sophie.jpeg")),
  filename: "sophie.jpeg",
  content_type: "image/jpeg"
)

user5 = User.create!(
  email: "test5@example.com",
  password: "password456",
  first_name: "Clara",
  last_name: "Pierre",
  city: "Lyon",
  sexe: "Feminin",
  preferences: "light mode",
  role: "teacher",
  sports: ["danse", "gym", "velo"],
  age_range: "18-25",
  latitude: 48.8600,
  longitude: 2.3490,
)

user5.avatar.attach(
  io: File.open(Rails.root.join("db/images/clara.jpg")),
  filename: "clara.jpg",
  content_type: "image/jpg"
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

puts "🗑️ Suppression des anciens événements..."
Event.destroy_all

puts "🌱 Création des événements..."

events = [
  {
    title: "Tennis en double",
    description: "Match de tennis en double pour améliorer votre jeu",
    location: "Parc Central, Paris",
    starts_at: Time.zone.now.change(hour: 10, min: 0),
    user: user1
  },
  {
    title: "Session running matinale",
    description: "Course en groupe pour commencer la journée en forme",
    location: "Bois de Boulogne",
    starts_at: 1.day.from_now.change(hour: 7, min: 0),
    user: user1
  },
  {
    title: "Yoga Sunrise",
    description: "Séance de yoga au lever du soleil face à la Seine",
    location: "Berges de Seine",
    starts_at: Date.today.next_occurring(:saturday).to_time.change(hour: 6, min: 30),
    user: user1
  },
  {
    title: "Sortie cyclisme",
    description: "Balade sportive en groupe dans la vallée de Chevreuse",
    location: "Gare Montparnasse",
    starts_at: Date.today.next_occurring(:sunday).to_time.change(hour: 9, min: 0),
    user: user1
  },
  {
    title: "CrossFit Challenge",
    description: "Séance intense de CrossFit avec coach certifié",
    location: "Salle FitFactory",
    starts_at: Date.today.next_occurring(:monday).to_time.change(hour: 18, min: 0),
    user: user1
  },
  {
    title: "Randonnée Montagne",
    description: "Marche en groupe dans les sentiers de Fontainebleau",
    location: "Gare de Fontainebleau",
    starts_at: Date.today.next_occurring(:tuesday).to_time.change(hour: 10, min: 0),
    user: user1
  },
  {
    title: "Entraînement Natation",
    description: "Session d’endurance et technique en piscine olympique",
    location: "Piscine Georges Vallerey",
    starts_at: Date.today.next_occurring(:wednesday).to_time.change(hour: 19, min: 0),
    user: user1
  }
]

events.each do |attrs|
  Event.create!(attrs)
end

puts "✅ #{Event.count} événements créés !"


puts "Seed terminée ✅"
