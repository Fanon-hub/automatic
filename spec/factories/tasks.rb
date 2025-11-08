FactoryBot.define do
  factory :task do
    title { "Sample Task" }
    content { "This is a sample task content." }
    created_at { Time.current }
  end
end
