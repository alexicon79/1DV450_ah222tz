object @user
attributes :id

node(:self) { |user| polymorphic_url([:api, :v1, user])}
node(:created) { |user| user.created_at }

code :info do |user|
  attributes  :name => user.name,
              :userName => user.username,
              :email => user.email
end
