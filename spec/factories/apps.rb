FactoryBot.define do
  factory :app do
    name { Faker::Educator.secondary_school }
    dg_app_id { rand(10..99) }
  end
end
