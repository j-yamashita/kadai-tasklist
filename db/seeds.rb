# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(name:"taro", email:"taro@suzuki.com", password:"taro1234")
User.create(name:"jiro", email:"jiro@suzuki.com", password:"jiro1234")
User.create(name:"saburo", email:"saburo@suzuki.com", password:"saburo1234")


states = ["未着手", "着手", "完了", "保留", "中止"]
(1..100).each do |i|
  Task.create(content: "タスク#{i}", status: states.sample, user_id: Random.rand(1..3))
end