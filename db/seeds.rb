# Create regular user
regular_user = User.create!(
  name: '一般ユーザー',
  email: 'user@example.com',
  password: 'password',
  admin: false
)

# Create admin user
admin_user = User.create!(
  name: '管理者',
  email: 'admin@example.com',
  password: 'password',
  admin: true
)

# Create 50 tasks for regular user
50.times do |i|
  regular_user.tasks.create!(
    title: "一般ユーザータスク #{i + 1}",
    content: "これは一般ユーザーのタスク #{i + 1} の内容です。",
    created_at: rand(1..60).days.ago
  )
end

# Create 50 tasks for admin user
50.times do |i|
  admin_user.tasks.create!(
    title: "管理者タスク #{i + 1}",
    content: "これは管理者のタスク #{i + 1} の内容です。",
    created_at: rand(1..60).days.ago
  )
end

puts "Created users: #{User.count}"
puts "Created tasks: #{Task.count}"