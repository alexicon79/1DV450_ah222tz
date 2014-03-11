# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  firstname       :string(255)
#  lastname        :string(255)
#  email           :string(255)
#  username        :string(255)
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  #has_secure_password
  attr_accessible :firstname, :lastname, :username, :email, :password, :password_confirmation
  has_many :resources

  validates :username, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :username

  #validates :password, presence: { on: :create }, length: { minimum: 5 }

  validates :email, presence: true, uniqueness: true


  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
      user.email = auth["info"]["email"]
      user.firstname = auth["info"]["name"] # could be updated (better check when new logins)
      user.token = auth["credentials"]["token"] # github provider token should not give out
      user.auth_token = SecureRandom.urlsafe_base64(nil, false) # generate a access_key for client to call the API
      user.token_expires = Time.now + 1.hour
      user.save
    end
  end

end
