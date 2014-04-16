module Api
  class ApiController < ActionController::Base
    skip_before_filter :verify_authenticity_token
    before_filter :authorize_token!
    #before_filter :http_basic_authenticate, :except => [:index, :show, :tag_resources, :user_resources, :licence_resources]
    before_filter :user_authenticate, :except => [:index, :show, :tag_resources, :user_resources, :licence_resources]

    respond_to :json, :xml

    def authorize_token!
      token = request.headers['APP-AUTH-TOKEN']
      unless ApiKey.exists?(access_token: token)
        render :text => "Invalid application access token", :status => :unauthorized
      end
    end

    # def http_basic_authenticate
    #   authenticate_or_request_with_http_basic do |username, password|
    #     @user = User.find_by_username(username)
    #     @user.authenticate(password)
    #   end
    # end

    def user_authenticate
      auth_token = request.headers['USER-AUTH-TOKEN']
      unless auth_token.present? && User.exists?(auth_token: auth_token)
        render :text => "Invalid user access token", :status => :unauthorized
      end
    end

  end
end
