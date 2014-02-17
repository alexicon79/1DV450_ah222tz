# == Schema Information
#
# Table name: applications
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  contact_email :string(255)
#

class Application < ActiveRecord::Base
  attr_accessible :contact_email
  has_one :api_key
end
