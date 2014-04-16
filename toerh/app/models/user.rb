# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  name            :string(255)
#  email           :string(255)
#  username        :string(255)
#  password_digest :string(255)
#  provider        :string(255)
#  uid             :string(255)
#  token           :string(255)
#  auth_token      :string(255)
#  token_expires   :datetime
#  client_expires  :string(255)
#

class User < ActiveRecord::Base
  #has_secure_password
  attr_accessible :name, :username, :email, :password, :password_confirmation, :auth_token
  has_many :resources

  validates :username, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :username

  #validates :password, presence: { on: :create }, length: { minimum: 5 }

  validates :email, presence: true, uniqueness: true


  def self.create_with_omniauth(auth)

    create! do |user|

      timeOneHour = Time.now + 1.hour

      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
      user.email = auth["info"]["email"]
      user.name = auth["info"]["name"]
      user.token = auth["credentials"]["token"]
      user.auth_token = SecureRandom.urlsafe_base64(nil, false) # generate access_key for client to call the API
      user.token_expires = timeOneHour
      user.client_expires = (timeOneHour.to_f * 1000).to_i
      user.save
    end
  end

end
