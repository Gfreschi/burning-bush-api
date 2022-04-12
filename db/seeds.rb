# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(name: 'Web Client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create!(name: 'Mobile', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create!(name: 'Backoffice', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create!(name: 'React', redirect_uri: '', scopes: '')
end

User.create(name: 'Gabriel F. - ADM',
            email: 'admin@admin.com',
            password: 'password',
            password_confirmation: 'password',
            role: User.roles[:admin])

User.create(name: 'Gabriel F. - USER',
            email: 'user@user.com',
            password: 'password',
            password_confirmation: 'password',
            role: User.roles[:user])

User.create(name: 'Fulano',
            email: 'fulano@user.com',
            password: 'password',
            password_confirmation: 'password',
            role: User.roles[:user])

Complaint.create(user_id: 1,
                 severity: 10,
                 details: 'Fogo no mato',
                 kind: Complaint.kinds[:burn])

Complaint.create(user_id: 1,
                 severity: 3,
                 details: 'Lixo no chão',
                 kind: Complaint.kinds[:trash])

Complaint.create(user_id: 1,
                 severity: 1,
                 details: 'Muito lixo',
                 kind: Complaint.kinds[:trash])

Complaint.create(user_id: 2,
                 severity: 5,
                 details: 'Entulho no terreno',
                 kind: Complaint.kinds[:trash])

Complaint.create(user_id: 2,
                 severity: 5,
                 details: 'FOGOOOO',
                 kind: Complaint.kinds[:burn])
