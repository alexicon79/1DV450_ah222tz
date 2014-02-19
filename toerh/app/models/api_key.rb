# == Schema Information
#
# Table name: api_keys
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  access_token   :string(255)
#  application_id :integer
#

class ApiKey < ActiveRecord::Base
  attr_accessible :access_token, :application_id
  before_create :generate_access_token
  belongs_to :application

  validates_presence_of :application
  validates_uniqueness_of :access_token

  private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

end
