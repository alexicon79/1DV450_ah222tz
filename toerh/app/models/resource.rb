# == Schema Information
#
# Table name: resources
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  resource_type_id :integer
#  licence_id       :integer
#  user_id          :integer
#  name             :string(255)
#  description      :string(255)
#  url              :string(255)
#

class Resource < ActiveRecord::Base
  attr_accessible :resource_type_id, :licence_id, :user_id, :tag_id, :name, :description, :url
  has_and_belongs_to_many :tags
  belongs_to :resource_type
  belongs_to :user
  belongs_to :licence
end
