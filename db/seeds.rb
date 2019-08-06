# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
flights = Flight.create([
    { origin: 'Raleigh', destination: 'Paris', departure_time: 1.days.from_now, duration: 25200, price: 300 }, 
    { origin: 'Raleigh', destination: 'Montreal', departure_time: 10.days.from_now, duration: 4600, price: 400 }, 
    { origin: 'Raleigh', destination: 'Neverland', departure_time: 11.days.from_now, duration: 3600, price: 500}, 
])
