# == Schema Information
#
# Table name: api_keys
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ApiKey < ActiveRecord::Base
  # attr_accessible :title, :body
end
