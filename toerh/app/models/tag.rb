# == Schema Information
#
# Table name: tags
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  resource_id :integer
#

class Tag < ActiveRecord::Base
  # attr_accessible :title, :body
end
