object @resource

node(:self) { |resource| polymorphic_url([:api, :v1, resource])}
node(:created) { |resource| resource.created_at }

code :info do |resource|
  attributes  :title => resource.name,
              :description => resource.description,
              :url => resource.url,
              :resourceType => resource.resource_type.type_name,
              :licence => resource.licence.licence_type.upcase
end

code :publisher do |resource|
  attributes  :name => resource.user.firstname + " " + resource.user.lastname,
              :email => resource.user.email,
              :userId => resource.user.id
end

child :tags do |tag|
  node(:tagName) { |tag| tag.tag_name}
end
