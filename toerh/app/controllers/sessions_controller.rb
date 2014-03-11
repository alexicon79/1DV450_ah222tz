class SessionsController < ApplicationController
  skip_before_filter :authorize

  def create
    auth = request.env["omniauth.auth"]
    puts YAML::dump(auth)

    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)


    # read back the session
    url = session[:client_call]
    session[:client_call] = nil
    redirect_to  "#{url}?auth_token=#{user.auth_token}&token_expires=#{Rack::Utils.escape(user.token_expires.to_s)}"
  end


  # def create
  #   auth = request.env["omniauth.auth"]
  #   puts YAML::dump(auth)

    #user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth["provider"], auth["uid"])

    # user.name = auth["info"]["name"]
    # user.token = auth["credentials"]["token"]
    # user.auth_token = SecureRandom.urlsafe_base64(nil, safe)
    # user.token_expires = Time.now + 1.hour
    # user.save

    # url = session[:client_call]
    # session[:client_call] = nil
    # redirect_to "#{url}?auth_token=#{user.auth_token}&token_expires=#{Rack::Utils.escape(user.token_expires.to_s)}"


    # user = User.find_by_username(params[:username])
    # if user.username == "admin" and user.authenticate(params[:password])
    #   session[:user_id] = user.id
    #   redirect_to applications_url
    # else
    #   redirect_to login_url, alert: "Invalid username and/or password"
    # end
  #end

  def destroy
  # session[:user_id] = nil
  # redirect_to login_url, notice: "Logged out"
  end

  def authenticate
    session[:client_call] = params[:callback]
    redirect_to "/auth/github"
  end

end
