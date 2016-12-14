FactoryGirl.define do
  factory :post do
    sequence (:title) { |n| "#{Faker::Hacker.noun} #{n}"}
    body {Faker::Hacker.say_something_smart}
  end
end
