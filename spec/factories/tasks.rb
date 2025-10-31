FactoryBot.define do
  factory :task do
    title { "Document Preparation" }
    content { "Create a proposal for the upcoming project." }
    
  end
  factory :second_task, class: Task do
    title { "Prepare for Interview" }
    content { "Review common interview questions and prepare answers." }
  end
end
