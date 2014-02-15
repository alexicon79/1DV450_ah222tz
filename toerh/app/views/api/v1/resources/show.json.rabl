object @resource
attributes :id

node(:title) { |resource| resource.name }
node(:description) { |resource| resource.description }
node(:url) { |resource| resource.url }
node(:createdAt) { |resource| resource.created_at }
node(:resourceTypeId) { |resource| resource.resource_type_id }
node(:resourceType) { |resource| resource.resource_type.type_name }
node(:userId) { |resource| resource.user_id }
node(:user) { |resource| resource.user.firstname + " " + resource.user.lastname }
node(:licenceId) { |resource| resource.licence_id }
node(:licence) { |resource| resource.licence.licence_type }

child :tags do
  node(:tagId) { |tag| tag.id}
  node(:tagName) { |tag| tag.tag_name}
end
