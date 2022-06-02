# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create(name: 'student')
Role.create(name: 'teacher')
Role.create(name: 'admin')

User.create(name: 'Ademiro', email: 'admin@mail.com', password: '123456', birthdate: '10/04/1999',
            role: Role.where(name: 'admin')[0])
