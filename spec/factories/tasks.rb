FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    content { "Task content" }
    deadline_on { Date.today + 1.week }
    priority { :medium }
    status { :not_started }
    created_at { Time.current }

    trait :high_priority do
      priority { :high }
    end

    trait :low_priority do
      priority { :low }
    end

    trait :in_progress do
      status { :in_progress }
    end

    trait :completed do
      status { :completed }
    end
  end
end