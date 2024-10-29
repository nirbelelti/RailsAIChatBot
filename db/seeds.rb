# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts 'Creating seeds'
# Create a default user
User.find_or_create_by!(email: 'email@email.com', password: 'Password', password_confirmation: 'Password')
4.times do
  User.create!(email: Faker::Internet.email, password: 'Password', password_confirmation: 'Password')
end if User.count < 5

puts 'Seeds created'

