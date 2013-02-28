# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
puts 'ROLES'
Preferences.ROLES.each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
admin = User.find_or_create_by_email :name => Preferences.ADMIN_NAME.dup, :email => Preferences.ADMIN_EMAIL.dup, :password => Preferences.ADMIN_PASSWORD.dup, :password_confirmation => Preferences.ADMIN_PASSWORD.dup
puts 'admin: ' << admin.name
admin.add_role :admin
admin.add_role :user
admin.approved = true

user = User.find_or_create_by_email :name => Preferences.USER_NAME.dup, :email => Preferences.USER_EMAIL.dup, :password => Preferences.USER_PASSWORD.dup, :password_confirmation => Preferences.USER_PASSWORD.dup
puts 'user: ' << user.name
user.add_role :user
user.approved = true
