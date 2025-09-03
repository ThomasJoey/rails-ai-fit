
# db/seeds.rb
require "faker"
require "open-uri"
require 'nokogiri'
require 'ruby_llm'

RubyLLM.configure do |config|
  config.openai_api_key = ENV['OPENAI_API_KEY']
end


SPORTS = [
  "running", "marathon", "trail", "marche", "randonnee", "velo", "triathlon",
  "musculation", "crossfit", "halterophilie", "pilates", "gymnastique",
  "football", "basketball", "volleyball", "handball", "rugby",
  "boxe", "mma", "judo", "lutte", "jiujitsu", "karate", "escrime",
  "natation", "waterpolo", "plongee", "surf", "voile", "kayak", "aviron",
  "ski", "snowboard", "patinage", "hockey", "biathlon",
  "tennis", "badminton", "squash", "pingpong", "padel",
  "yoga", "danse", "athletisme", "golf", "equitation", "escalade",
  "skateboard", "roller", "bowling", "billard", "flechettes", "petanque",
  "tir_arc", "chasse", "peche", "fitness", "zumba", "spinning",
  "aerobic", "stretching"
];

NAMES = [
  "Alice",
  "Bob",
  "Charlie",
  "Diana",
  "Ethan",
  "Fiona",
  "George",
  "Hannah",
  "Ivan",
  "Julia",
  "Kevin",
  "Laura",
  "Michael",
  "Nina",
  "Oscar",
  "Paula",
  "Quentin",
  "Rachel",
  "Sam",
  "Tina"
]

def email_for(name, domain = "example.com")
  normalized = name.downcase
  .gsub(/[^a-z]/, '') # keep only letters
  "#{normalized}@#{domain}"
end

def generate_text(keywords)
  prompt = <<~PROMPT
    Écris un court texte descriptif (2–3 phrases) qui utilise les mots-clés suivants :
    #{keywords}.
  PROMPT

  chat = RubyLLM.chat
  response = chat.ask(prompt)
  response.content.strip
end

def generate_image(prompt)
  URI.parse("https://image.pollinations.ai/prompt/#{URI.encode_www_form_component(prompt)}").open
end

def get_random_sports(number: 1)
  SPORTS.sample(number)
end

Faker::Config.locale = :fr

puts "🗑️ Nettoyage de la base..."
Conversation.destroy_all
Event.destroy_all
Match.destroy_all
Comment.destroy_all
Like.destroy_all
Post.destroy_all
User.destroy_all

puts "👤 Création des utilisateurs..."

puts "👤 Création des utilisateurs avec Faker..."
users = NAMES.map do |name|
  User.create!(
    email: email_for(name),
    password: "password123",
    first_name: name,
    last_name: Faker::Name.last_name,
    city: "Paris",
    role: "",
    sports: ["vélo"] + (SPORTS - ["vélo"]).sample(2), # toujours vélo + 2 autres
    age_range: "18-25",
    location: "Paris"
  )
end
puts "✅ #{users.count} utilisateurs créés"

puts "💬 Création des conversations..."
conversations = [
  {
    title: "Apprentissage Rails",
    context: "On discute des migrations et seeds pour le bootcamp.",
    status: "active",
    user: User.first,
    second_user: User.all.sample
  },
  {
    title: "Projet Final",
    context: "Organisation des tâches du projet collaboratif.",
    status: "pending",
    user: User.third,
    second_user: User.all.sample
  },
  {
    title: "Pause café",
    context: "Discussion informelle entre les étudiants.",
    status: "archived",
    user: User.second,
    second_user: User.all.sample
  }
]
conversations.each do |attrs|

  begin
    Conversation.create!(attrs)
  rescue StandardError => e
    puts "⚠️ Erreur sur la conversation '#{attrs[:title]}': #{e.message}"
  end
end
puts "✅ #{Conversation.count} conversations créées"

puts "🎉 Création des événements..."

events = Array.new(10) do |index|
  addresses = [
    "12 Rue de Rivoli, 75001 Paris",
    "45 Boulevard Saint-Germain, 75005 Paris",
    "8 Avenue de l’Opéra, 75001 Paris",
    "22 Rue des Martyrs, 75009 Paris",
    "101 Rue de Rennes, 75006 Paris",
    "64 Boulevard Haussmann, 75009 Paris",
    "18 Rue de la Roquette, 75011 Paris",
    "77 Avenue des Champs-Élysées, 75008 Paris",
    "5 Rue Mouffetard, 75005 Paris",
    "30 Rue de Belleville, 75020 Paris"
  ]

  title = [
    "Sortie vélo entre amis 🚴",
    "Session running au parc 🏃‍♀️",
    "Match de tennis improvisé 🎾",
    "Cours de yoga au lever du soleil 🧘‍♂️",
    "Randonnée en forêt 🌲"
  ].sample

  Event.create!(
    title: title ,
    description: generate_text(title),
    location: addresses[index],
    starts_at: Faker::Time.forward(days: 20, period: :day),
    user: users.sample
  )
end
puts "✅ #{events.count} événements créés en français"

puts "📝 Création des posts avec photos..."

posts = 5.times.map do
  user = users.sample # ou bien choisis un seul user fixe

  keywords = [
    "fitness", "workout", "training", "exercise", "strength", "endurance",
    "athlete", "sportsmanship", "motivation", "discipline", "competition",
    "teamwork", "coaching", "performance", "recovery", "nutrition", "mindset",
    "goalsetting", "health", "wellness", "cardio", "strengthtraining", "gym",
    "lifestyle", "progress", "consistency", "energy", "focus", "champion", "grind"
  ]

  selected_keywords = keywords.sample(3)

  post = Post.create!(
    user: user,
    content_text: generate_text(selected_keywords) # ici tu peux passer le tableau directement
  )

  # Récupère une image aléatoire (sport / fitness / nature)
  begin
    sleep 1
    file = generate_image(selected_keywords.join(","))
    post.photo.attach(io: file, filename: "post#{post.id}.jpg", content_type: "image/jpg")
  rescue => e
    puts "⚠️ Impossible de télécharger une image : #{e.message}"
  end

  puts "✅ Nouveau post ##{post.id} avec #{selected_keywords.join(", ")}"
  post
end

puts "📊 Total : #{Post.count} posts créés"


puts "💬 Création des commentaires..."
comments = posts.flat_map do |post|
  Array.new(rand(1..3)) do
    Comment.create!(
      user: users.sample,
      post: post,
      content_text: [
        "Trop cool ! 🙌",
        "Je veux participer !",
        "Ça a l’air sympa, comptez sur moi 😎",
        "Bravo pour l’organisation 👏",
        "Dispo la semaine prochaine aussi !"
      ].sample
    )
  end
end
puts "✅ #{Comment.count} commentaires créés"

puts "👍 Création des likes..."
likes = posts.flat_map do |post|
  users.sample(rand(0..users.count)).map do |user|
    Like.create!(user: user, post: post)
  end
end
puts "✅ #{Like.count} likes créés"
puts "🌱 Seed terminée avec succès ✅"
