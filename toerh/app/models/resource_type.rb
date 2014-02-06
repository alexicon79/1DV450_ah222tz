# == Schema Information
#
# Table name: resource_types
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_type :string(255)
#

class ResourceType < ActiveRecord::Base
  attr_accessible :resource_type
  has_many :resources
end
