FactoryBot.define do
  factory :user do
    app
    name { Faker::Name.name }
    email { "#{name.split.join('_').downcase}@#{Faker::Internet.domain_name}" }
    fractal_id { rand(1000..9_999) }
    photo_url { Faker::Avatar.image }
    token_dg { Faker::Internet.uuid }
    status { Status::ACTIVE }
    role { nil }
  end
end
