# == Schema Information
#
# Table name: licences
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Licence < ActiveRecord::Base
  # attr_accessible :title, :body
end
