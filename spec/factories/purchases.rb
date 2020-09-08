FactoryBot.define do
  factory :purchase do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    cost { 1.99 }
    attached_image { Rack::Test::UploadedFile.new('assets/1.jpeg', '1.jpeg') }
  end
end
