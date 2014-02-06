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

require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
