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
  before_validation :to_lower_case

  validates_presence_of :type_name
  validates_uniqueness_of :type_name

  protected

  def to_lower_case
    unless self.type_name.nil?
      self.type_name.downcase!
    end
  end
end
