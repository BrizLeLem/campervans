# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create users
require "faker"
require "date"
Booking.destroy_all
User.destroy_all
Campervan.destroy_all

user = User.new(email: "briz@superdry.com", first_name: "Briz", last_name: "LM")
user.password = "sunshine"
user.save

user = User.new(email: "alizeh@trails.com", first_name: "Alizeh", last_name: "K")
user.password = "sunshine"
user.save

user = User.new(email: "leeanna@hollywood.com", first_name: "Leeanna", last_name: "S")
user.password = "sunshine"
user.save

user = User.new(email: "thomas@dogs.com", first_name: "Thomas", last_name: "P")
user.password = "sunshine"
user.save

campervan_owners = [User.all.sample, User.all.sample]

brands = %w(Volkswagen Fiat Hyundai Mercedes)
models = %w(X1 T3 W7 LT DRIVE SUPER quicks)

5.times do
  campervan = Campervan.new(title: Faker::FunnyName.two_word_name, description: Faker::GreekPhilosophers.quote, brand: brands.sample, model: models.sample, capacity: (1..6).to_a.sample, price_per_night: (40..100).to_a.sample)
  campervan.user = campervan_owners.sample
  campervan.save
end


# create bookings
5.times do
  start_date = Date.new(2020, 11, 15)
  days = (rand*10).floor
  end_date = start_date + days

  campervan = Campervan.all.sample
  user = User.all.sample
  unless campervan.user != user
  campervan = Campervan.all.sample
  user = User.all.sample
  end

  booking = Booking.new(start_date: start_date, end_date: end_date, total_price: campervan.price_per_night * days)
  booking.campervan = campervan
  booking.user = user
  booking.save
end

p "seeds created"
