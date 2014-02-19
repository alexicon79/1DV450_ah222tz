object @tag

node(:self) { |tag| polymorphic_url([:api, :v1, tag])}
node(:created) { |tag| tag.created_at }
node(:tagName) { |tag| tag.tag_name }
