User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.name = 'admin'
  user.admin = true
  user.password = 'password'
  user.password_confirmation = 'password'
end

Label.create!(name: 'work')
Label.create!(name: 'private')
Label.create!(name: 'other')

7.times do |n|
  Label.create!(
    name: "No.#{n + 1}"
  )
end

20.times do |n|
  User.create!(
    name: "#{n + 1}番さん",
    email: "user#{n + 1}@example.com",
    password: "password#{n + 1}"
  )
end

20.times do |n|
  Task.create!(
    title: "やること#{n + 1}",
    content: "プログラミング勉強#{n + 1}",
    deadline: Time.current + (n).days,
    status: "New",
    priority: "normal",
    user_id: 1,
    label_ids: 2
  )
end
