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
#  tag_id           :integer
#

class Resource < ActiveRecord::Base
  # attr_accessible :title, :body
end
