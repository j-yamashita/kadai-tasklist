# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

states = ["未着手", "着手", "完了", "保留", "中止"]
(1..100).each do |i|
  Task.create(content: "タスク#{i}", status: states.sample)
end