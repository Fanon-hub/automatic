FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    content { "Task content" }
    deadline_on { Date.today + 1.week }
    priority { :medium }
    status { :not_started }
    created_at { Time.current } 
    association :user 

    trait :high_priority do
      priority { :high }
    end

    trait :low_priority do
      priority { :low }
    end

    trait :not_started do
      status { :not_started }
    end

    trait :in_progress do
      status { :in_progress }
    end

    trait :completed do
      status { :completed }
    end

    trait :due_today do
      deadline_on { Date.current }
    end

    trait :overdue do
      deadline_on { Date.current - 1.day }
    end

    trait :due_tomorrow do
      deadline_on { Date.current + 1.day }
    end

    trait :created_yesterday do
      created_at { Time.current - 1.day }
    end

    trait :created_last_week do
      created_at { Time.current - 1.week }
    end
  end
end