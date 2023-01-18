FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    isbn { Faker::Code.isbn }
    published { Faker::Date.between(from: 100.years.ago, to: Date.today) }
    image { Faker::LoremFlickr.image }
    description { Faker::Lorem.paragraph }
    genre { Faker::Book.genre }
  end
end
