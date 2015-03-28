# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Bill.create(public_key: "1FKFwaN8UBLDjvFKJikfxzWpvKqmnkEXRC", private_key: "L32sZdW1oxxEytQmLjKbUKYgUbQ7qCtF2nTPdea9LiesBPmN7ag3", qr_name: "test")
Bill.create(public_key: "test2", private_key: "test2", qr_name: "test2")
Bill.create(public_key: "test3", private_key: "test3", qr_name: "test3")

