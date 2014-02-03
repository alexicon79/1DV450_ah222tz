# == Schema Information
#
# Table name: applications
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Application < ActiveRecord::Base
  # attr_accessible :title, :body
end
