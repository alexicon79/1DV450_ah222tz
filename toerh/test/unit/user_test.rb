# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  name            :string(255)
#  email           :string(255)
#  username        :string(255)
#  password_digest :string(255)
#  provider        :string(255)
#  uid             :string(255)
#  token           :string(255)
#  auth_token      :string(255)
#  token_expires   :datetime
#  client_expires  :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
