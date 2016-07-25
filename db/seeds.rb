# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

seed_users = User.create([{ username: 'sys_admin', email: 'sys_admin@ctpt.io', password: 12345678, password_confirmation: 12345678 }]) if User.count == 0
