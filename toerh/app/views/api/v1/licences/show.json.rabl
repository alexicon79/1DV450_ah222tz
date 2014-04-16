object @licence
attributes :id

node(:self) { |licence| polymorphic_url([:api, :v1, licence])}
node(:created) { |licence| licence.created_at }
node(:licenceName) { |licence| licence.licence_type }
