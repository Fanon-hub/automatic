puts 'Creating tasks...'

10.times do |i|
  Task.create!(
    title: "Task #{i + 1}",
    content: "This is task #{i + 1} content",
    deadline_on: Date.today + (i + 1).days,
    priority: i % 3,
    status: i % 3
  )
end

puts 'Created 10 tasks with different values!'