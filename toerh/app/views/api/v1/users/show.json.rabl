object @user

node(:self) { |user| polymorphic_url([:api, :v1, user])}
node(:created) { |user| user.created_at }

code :info do |user|
  attributes  :firstName => user.firstname,
              :lastName => user.lastname,
              :email => user.email
end

