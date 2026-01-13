FactoryBot.define do
  factory :label do
    name { "My Label" }
    association :user 
  end
end