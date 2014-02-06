# == Schema Information
#
# Table name: licences
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  licence_type :string(255)
#

class Licence < ActiveRecord::Base
  attr_accessible :licence_type
  has_many :resources
end
