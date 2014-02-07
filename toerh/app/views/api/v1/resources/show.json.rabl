object @resource
attributes :id, :name, :description, :url

node(:resource_type) { |resource| resource.resource_type.type_name }
node(:resource_type_id) { |resource| resource.resource_type_id }
node(:author) { |resource| resource.user.firstname + " " + resource.user.lastname }
node(:author_id) { |resource| resource.user_id }
node(:licence) { |resource| resource.licence.licence_type }
node(:licence_id) { |resource| resource.licence_id }

child :tags do
  attributes :tag_name, :id
end
