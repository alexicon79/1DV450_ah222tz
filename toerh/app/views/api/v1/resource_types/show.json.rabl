object @resource_type
attributes :id

node(:self) { |resource_type| polymorphic_url([:api, :v1, resource_type])}
node(:created) { |resource_type| resource_type.created_at }
node(:resourceType) { |resource_type| resource_type.type_name }
