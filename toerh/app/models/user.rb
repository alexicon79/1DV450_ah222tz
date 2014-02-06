# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  firstname  :string(255)
#  lastname   :string(255)
#  email      :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :email
  has_many :resources
end
