FactoryBot.define do
  factory :image do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    price { 1.99 }

    private { false }

    attached_image { Rack::Test::UploadedFile.new('assets/1.jpeg', '1.jpeg') }
  end
end
