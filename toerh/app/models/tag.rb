# == Schema Information
#
# Table name: tags
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  resource_id :integer
#  tag_name    :string(255)
#

class Tag < ActiveRecord::Base
  attr_accessible :tag_name
  has_and_belongs_to_many :resources
end
