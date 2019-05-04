# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create(name: "Cliente")
Role.create(name: "Tendero")

User.create(name: "Luis", lastname: "Gil", email: "luegilca@unal.edu.co", password: "12345678", password_confirmation: "12345678", role_id: 1)
Wallet.create(activation_date: DateTime.now.to_date, last_activity_date: DateTime.now.to_date, maximum_value: 10000000, current_value: 1000, user_id: 1)
User.create(name: "Ernesto", lastname: "Castellanos", email: "luergica@gmail.com", password: "12345678", password_confirmation: "12345678", role_id: 1)
Wallet.create(activation_date: DateTime.now.to_date, last_activity_date: DateTime.now.to_date, maximum_value: 10000000, current_value: 1000, user_id: 2)

User.create(name: "Camilo", lastname: "Dajer", email: "cadajer@unal.edu.co", password: "12345678", password_confirmation: "12345678", role_id: 2)


TransactionType.create(name: "Transferencia")
TransactionType.create(name: "Pago")

Service.create(name: "Acueducto Agua")
Service.create(name: "Codensa Energia")