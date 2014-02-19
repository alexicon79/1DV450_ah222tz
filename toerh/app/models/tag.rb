# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tag_name   :string(255)
#

class Tag < ActiveRecord::Base
  attr_accessible :tag_name, :resource_id
  has_and_belongs_to_many :resources
  before_validation :to_lower_case

  validates_presence_of :tag_name
  validates_uniqueness_of :tag_name

  protected

  def to_lower_case
    unless self.tag_name.nil?
      self.tag_name.downcase!
    end
  end
end
