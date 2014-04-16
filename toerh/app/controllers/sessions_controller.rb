class SessionsController < ApplicationController
  skip_before_filter :authorize

  def create
    auth = request.env["omniauth.auth"]

    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)

    # set user token to expire in one hour
    timeOneHour = Time.now + 1.hour
    user.client_expires = (timeOneHour.to_f * 1000).to_i
    user.save

    # read back the session
    url = session[:client_call]
    session[:client_call] = nil
    redirect_to  "#{url}#/authenticated?&name=#{Rack::Utils.escape(user.name)}&auth_token=#{user.auth_token}&token_expires=#{user.client_expires}"
  end

  def destroy
  # session[:user_id] = nil
  # redirect_to login_url, notice: "Logged out"
  end

  def authenticate
    session[:client_call] = params[:callback]
    redirect_to "/auth/github"
  end

end
