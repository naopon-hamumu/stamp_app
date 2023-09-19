# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do
  user = User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )

  2.times do
    user.stamp_rallies.create!(
      title: 'そうちゃんかわゆい',
      description: Faker::Quote.famous_last_words,
      visibility: :public_open,
      stamps_attributes: [
        {
          name: 'スタンプ',
          sticker: File.open("./app/assets/images/ham1.jpg"),
          latitude: Faker::Address.latitude,
          longitude: Faker::Address.longitude,
          address: Faker::Address.full_address
        }
      ]
    )
  end
end