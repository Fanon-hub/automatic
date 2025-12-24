# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do |i|
  Task.create!(
    title: "Seed Task #{i + 1}",
    content: "Seed content #{i + 1}",
    created_at: Time.current - i.days  # Vary dates for sort test
  )
end
puts "Created 50 tasks!"