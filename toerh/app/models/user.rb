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
  attr_accessible :firstname, :lastname, :username, :email, :password, :password_confirmation
  has_many :resources
  has_secure_password

  validates :username, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :username

  validates_presence_of :password, on: :create
  validates_length_of :password, minimum: 5

  validates :email, presence: true, uniqueness: true
end
