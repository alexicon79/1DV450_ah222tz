# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  ResourceType.create([{resource_type: 'Image'}, {resource_type: 'Video'}, {resource_type: 'Article'}, {resource_type: 'Blogpost'}, {resource_type: 'Code'}])
  Licence.create([{licence_type: 'CC'}, {licence_type: 'MIT'}, {licence_type: 'GNU'}])
  User.create([{firstname: 'Alexander', lastname: 'Hall', email: 'ah222tz@student.lnu.se'}, {firstname: 'John', lastname: 'Doe', email: 'john@dodo.com'}, {firstname: 'Jane', lastname: 'Fonda'}])
  Resource.create([{resource_type_id: 1, licence_id: 2, user_id: 1}])
  t = Tag.create([{tag_name: 'RandomTag'}, {tag_name: 'SecondTag'}])

  r = Resource.first
  r.tags << t
