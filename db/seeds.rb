# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

topics = [
  { title: "Fate", genre: "Anime" },
  { title: "Haikyu", genre: "Anime" },
  { title: "Black Basket", genre: "Anime" }
]


topics.each do |topic|
  Topic.create(title: topic[:title], genre: topic[:genre])
end
