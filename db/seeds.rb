puts "Nettoyage de la base..."
Conversation.destroy_all
Event.destroy_all
Match.destroy_all
User.destroy_all


puts "Création des utilisateurs..."
# db/seeds.rb

# db/seeds.rb

# ===== Groupe A : 18-25 (sport commun: Vélo) =====
user1  = User.create!(
  email: "test@example1.com",  password: "password123",
  first_name: "Lina",  last_name: "Durand",
  city: "Paris", role: "",
  sports: ["Vélo", "Marathon", "Trail"],
  age_range: "18-25",
  location: "Paris, 1er arrondissement"
)

user2  = User.create!(
  email: "test@example2.com",  password: "password123",
  first_name: "Noah",  last_name: "Bernard",
  city: "Paris", role: "",
  sports: ["Vélo", "Running", "Triathlon"],
  age_range: "18-25",
  location: "Paris, 2e arrondissement"
)

user3  = User.create!(
  email: "test@example3.com",  password: "password123",
  first_name: "Maya",  last_name: "Petit",
  city: "Paris", role: "",
  sports: ["Vélo", "Randonnée", "Musculation"],
  age_range: "18-25",
  location: "Paris, 3e arrondissement"
)

user4  = User.create!(
  email: "test@example4.com",  password: "password123",
  first_name: "Elias",  last_name: "Robert",
  city: "Paris", role: "",
  sports: ["Vélo", "CrossFit-Hyrox", "Haltérophilie"],
  age_range: "18-25",
  location: "Paris, 4e arrondissement"
)

user5  = User.create!(
  email: "test@example5.com",  password: "password123",
  first_name: "Zoé",  last_name: "Moreau",
  city: "Paris", role: "",
  sports: ["Vélo", "Aviron", "Kayak"],
  age_range: "18-25",
  location: "Paris, 5e arrondissement"
)


user6  = User.create!(
  email: "test@example6.com",  password: "password123",
  first_name: "Yanis", last_name: "Garcia",
  city: "Paris", role: "",
  sports: ["Vélo", "Basketball", "Volleyball"],
  age_range: "26-35",
  location: "Paris, 6e arrondissement"
)

user7  = User.create!(
  email: "test@example7.com",  password: "password123",
  first_name: "Éva", last_name: "Lambert",
  city: "Paris", role: "",
  sports: ["Vélo", "Handball", "Boxe"],
  age_range: "26-35",
  location: "Paris, 7e arrondissement"
)

user8  = User.create!(
  email: "test@example8.com",  password: "password123",
  first_name: "Sami", last_name: "Rousseau",
  city: "Paris", role: "",
  sports: ["Vélo", "MMA", "Rugby"],
  age_range: "26-35",
  location: "Paris, 8e arrondissement"
)

user9  = User.create!(
  email: "test@example9.com",  password: "password123",
  first_name: "Inès", last_name: "Fournier",
  city: "Paris", role: "",
  sports: ["Vélo", "Badminton", "Tennis"],
  age_range: "26-35",
  location: "Paris, 9e arrondissement"
)

user10 = User.create!(
  email: "test@example10.com", password: "password123",
  first_name: "Léo", last_name: "Chevalier",
  city: "Paris", role: "",
  sports: ["Vélo", "Squash", "Ping-pong"],
  age_range: "26-35",
  location: "Paris, 10e arrondissement"
)

user11 = User.create!(
  email: "test@example11.com", password: "password123",
  first_name: "Chloé", last_name: "Lopez",
  city: "Paris", role: "",
  sports: ["Vélo", "Aviron", "Triathlon"],
  age_range: "36-45",
  location: "Paris, 11e arrondissement"
)

user12 = User.create!(
  email: "test@example12.com", password: "password123",
  first_name: "Nolan", last_name: "Martins",
  city: "Paris", role: "",
  sports: ["Vélo", "Ski", "Snowboard"],
  age_range: "36-45",
  location: "Paris, 12e arrondissement"
)

user13 = User.create!(
  email: "test@example13.com", password: "password123",
  first_name: "Amina", last_name: "Girard",
  city: "Paris", role: "",
  sports: ["Natation", "Plongée", "Surf"],
  age_range: "36-45",
  location: "Paris, 13e arrondissement"
)

user14 = User.create!(
  email: "test@example14.com", password: "password123",
  first_name: "Hugo", last_name: "Morel",
  city: "Paris", role: "",
  sports: ["Vélo", "Voile", "Kayak"],
  age_range: "36-45",
  location: "Paris, 14e arrondissement"
)

user15 = User.create!(
  email: "test@example15.com", password: "password123",
  first_name: "Sarah", last_name: "Renard",
  city: "Paris", role: "",
  sports: ["Vélo", "Escrime", "Athlétisme"],
  age_range: "36-45",
  location: "Paris, 15e arrondissement"
)

# ===== Groupe D : 46-55 (sport commun: Yoga) =====
user16 = User.create!(
  email: "test@example16.com", password: "password123",
  first_name: "Karim", last_name: "Perrin",
  city: "Paris", role: "",
  sports: ["Vélo", "Danse", "Pilates"],
  age_range: "46-55",
  location: "Paris, 16e arrondissement"
)

user17 = User.create!(
  email: "test@example17.com", password: "password123",
  first_name: "Mina", last_name: "Leroux",
  city: "Paris", role: "",
  sports: ["Yoga", "Golf", "Équitation"],
  age_range: "46-55",
  location: "Paris, 17e arrondissement"
)

user18 = User.create!(
  email: "test@example18.com", password: "password123",
  first_name: "Arthur", last_name: "Leblanc",
  city: "Paris", role: "",
  sports: ["Vélo", "Tennis", "Padel"],
  age_range: "46-55",
  location: "Paris, 18e arrondissement"
)

user19 = User.create!(
  email: "test@example19.com", password: "password123",
  first_name: "Nadia", last_name: "Gonzalez",
  city: "Paris", role: "",
  sports: ["Vélo", "Haltérophilie", "Musculation"],
  age_range: "46-55",
  location: "Paris, 19e arrondissement"
)

user20 = User.create!(
  email: "test@example20.com", password: "password123",
  first_name: "Theo", last_name: "Faure",
  city: "Paris", role: "",
  sports: ["Vélo", "Aviron", "Marathon"],
  age_range: "46-55",
  location: "Paris, 20e arrondissement"
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
