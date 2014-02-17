# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



  resource_type = ResourceType.create([{type_name: 'Image'}, {type_name: 'Video'}, {type_name: 'Article'}, {type_name: 'Blogpost'}, {type_name: 'Code'}])
  licence = Licence.create([{licence_type: 'CC'}, {licence_type: 'MIT'}, {licence_type: 'GNU'}])

  20.times do
    firstname = Faker::Name.first_name
    lastname = Faker::Name.last_name
    email = Faker::Internet.email
    username = Faker::Internet.user_name
    password = "password"

    user = User.create({firstname: firstname, lastname: lastname, username: username, email: email, password: password, password_confirmation: password})

    type_id = rand(1..5)
    licence_id = rand(1..3)
    user_id = rand(1..10)
    name = Faker::Lorem.words(2).join(" ")
    description = Faker::Lorem.words(6).join(" ")
    url = Faker::Internet.url

    resource = Resource.create({resource_type_id: type_id, licence_id: licence_id, user_id: user_id, name: name, description: description, url: url})

    tag1 = Tag.create({tag_name: Faker::Lorem.word})
    tag2 = Tag.create({tag_name: Faker::Lorem.word})
    resource.tags << tag1
    resource.tags << tag2
  end
