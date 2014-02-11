# == Schema Information
#
# Table name: resource_types
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type_name  :string(255)
#

class ResourceType < ActiveRecord::Base
  attr_accessible :type_name
  has_many :resources
end
