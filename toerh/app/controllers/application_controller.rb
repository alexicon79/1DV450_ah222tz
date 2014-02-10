class ApplicationController < ActionController::Base
  protect_from_forgery

  def get_all
    return Resource.all
  end
end
