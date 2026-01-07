# db/seeds.rb

Task.delete_all
User.delete_all

puts "Cleared all data."

# Create general user
user = User.create!(
  name: "General User",
  email: "user@example.com",
  password: "password",
  admin: false
)

# Create admin user
admin = User.create!(
  name: "Administrator",
  email: "admin@example.com",
  password: "password",
  admin: true
)

puts "Created 2 users."

# Create 50 tasks for each user
50.times do |i|
  Task.create!(
    user: user,
    title: "User Task #{i + 1}",
    content: "Content for user task #{i + 1}",
    deadline_on: Date.current + (i + 1).days,
    priority: [:low, :medium, :high].sample,
    status: [:not_started, :in_progress, :completed].sample
  )

  Task.create!(
    user: admin,
    title: "Admin Task #{i + 1}",
    content: "Content for admin task #{i + 1}",
    deadline_on: Date.current + (i + 1).days,
    priority: [:low, :medium, :high].sample,
    status: [:not_started, :in_progress, :completed].sample
  )
end

puts "Seeding completed!"
puts "Users: #{User.count}"
puts "Tasks: #{Task.count} (50 per user)"