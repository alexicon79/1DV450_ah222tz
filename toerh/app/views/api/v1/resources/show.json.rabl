object @resource
attributes :id, :name, :description, :url

node(:type) { |resource| resource.resource_type.type_name }
node(:created_by_user) { |resource| resource.user.firstname + " " + resource.user.lastname }
node(:licence) { |resource| resource.licence.licence_type }


child :tags do
  attributes :tag_name
end
