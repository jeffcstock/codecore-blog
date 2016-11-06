# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  Tag.create!(name: Faker::Book.genre)
end

5.times do
  User.create!({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: '123'
    })
end

tags = Tag.all
users = User.all
puts '20 Tags created!✔️'

50.times do
  p = Post.create!({ title: Faker::Company.catch_phrase,
                body:  Faker::Hacker.say_something_smart,
                tags: tags.sample(rand(2) + 1) })

  p.stars = users.map { |u| Star.new(count: rand(6), user: u, post: p)}

end

puts '50 Posts, 20 Tags, and 5 Users created! ✨😁✨'
