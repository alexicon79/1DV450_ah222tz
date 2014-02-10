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
  scope :none, where(:id => nil).where("id IS NOT ?", nil)

        def get_resources_by_user_id_model
        # return resources if param value is a number less than total amount of users
        if params[:user].to_i <= User.all.count && params[:user].to_i != 0
          return User.find(params[:user]).resources
        else
          return nil
        end
      end

end
