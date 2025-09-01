puts "Nettoyage de la base..."
Conversation.destroy_all
Event.destroy_all
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

# ===== Groupe B : 26-35 (sport commun: Football) =====
user6  = User.create!(
  email: "test@example6.com",  password: "password123",
  first_name: "Yanis", last_name: "Garcia",
  city: "Paris", role: "",
  sports: ["Football", "Basketball", "Volleyball"],
  age_range: "26-35",
  location: "Paris, 6e arrondissement"
)

user7  = User.create!(
  email: "test@example7.com",  password: "password123",
  first_name: "Éva", last_name: "Lambert",
  city: "Paris", role: "",
  sports: ["Football", "Handball", "Boxe"],
  age_range: "26-35",
  location: "Paris, 7e arrondissement"
)

user8  = User.create!(
  email: "test@example8.com",  password: "password123",
  first_name: "Sami", last_name: "Rousseau",
  city: "Paris", role: "",
  sports: ["Football", "MMA", "Rugby"],
  age_range: "26-35",
  location: "Paris, 8e arrondissement"
)

user9  = User.create!(
  email: "test@example9.com",  password: "password123",
  first_name: "Inès", last_name: "Fournier",
  city: "Paris", role: "",
  sports: ["Football", "Badminton", "Tennis"],
  age_range: "26-35",
  location: "Paris, 9e arrondissement"
)

user10 = User.create!(
  email: "test@example10.com", password: "password123",
  first_name: "Léo", last_name: "Chevalier",
  city: "Paris", role: "",
  sports: ["Football", "Squash", "Ping-pong"],
  age_range: "26-35",
  location: "Paris, 10e arrondissement"
)

# ===== Groupe C : 36-45 (sport commun: Natation) =====
user11 = User.create!(
  email: "test@example11.com", password: "password123",
  first_name: "Chloé", last_name: "Lopez",
  city: "Paris", role: "",
  sports: ["Natation", "Aviron", "Triathlon"],
  age_range: "36-45",
  location: "Paris, 11e arrondissement"
)

user12 = User.create!(
  email: "test@example12.com", password: "password123",
  first_name: "Nolan", last_name: "Martins",
  city: "Paris", role: "",
  sports: ["Natation", "Ski", "Snowboard"],
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
  sports: ["Natation", "Voile", "Kayak"],
  age_range: "36-45",
  location: "Paris, 14e arrondissement"
)

user15 = User.create!(
  email: "test@example15.com", password: "password123",
  first_name: "Sarah", last_name: "Renard",
  city: "Paris", role: "",
  sports: ["Natation", "Escrime", "Athlétisme"],
  age_range: "36-45",
  location: "Paris, 15e arrondissement"
)

# ===== Groupe D : 46-55 (sport commun: Yoga) =====
user16 = User.create!(
  email: "test@example16.com", password: "password123",
  first_name: "Karim", last_name: "Perrin",
  city: "Paris", role: "",
  sports: ["Yoga", "Danse", "Pilates"],
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
  sports: ["Yoga", "Tennis", "Padel"],
  age_range: "46-55",
  location: "Paris, 18e arrondissement"
)

user19 = User.create!(
  email: "test@example19.com", password: "password123",
  first_name: "Nadia", last_name: "Gonzalez",
  city: "Paris", role: "",
  sports: ["Yoga", "Haltérophilie", "Musculation"],
  age_range: "46-55",
  location: "Paris, 19e arrondissement"
)

user20 = User.create!(
  email: "test@example20.com", password: "password123",
  first_name: "Theo", last_name: "Faure",
  city: "Paris", role: "",
  sports: ["Yoga", "Aviron", "Marathon"],
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
