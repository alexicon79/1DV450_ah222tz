module Api
  module V1
    class ResourcesController < ApplicationController
      before_filter :restrict_access
      respond_to :html, :json, :xml

      def index
        # @resources = Resource.find(:all, :order => 'created_at DESC')
        @resources = {title: 'hej', body: 'body'}
        respond_with @resources
      end

      private
      def restrict_access
        api_key = ApiKey.find_by_access_token(params[:access_token])
        head :unauthorized unless api_key

          #use this solution instead?
          #authenticate_or_request_with_http_token do |token, options|
          #ApiKey.exists?(access_token: token)
      end
    end
  end
end