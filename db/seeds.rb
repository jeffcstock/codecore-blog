# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do
  Tag.create(name: Faker::Book.genre)
end

tags = Tag.all
puts '20 Tags created!✔️'

50.times do
  Post.create({ title: Faker::Company.catch_phrase,
                body:  Faker::Hacker.say_something_smart,
                tags: tags.sample(rand(2) + 1) })
end

puts '50 Posts created! 😁'
