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
  before_validation :to_lower_case

  validates_presence_of :licence_type
  validates_uniqueness_of :licence_type

  private

  def to_lower_case
    unless self.licence_type.nil?
      self.licence_type.downcase!
    end
  end
end
