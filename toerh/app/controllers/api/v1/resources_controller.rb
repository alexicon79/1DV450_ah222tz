module Api
  module V1
    class ResourcesController < ApplicationController
      #before_filter :restrict_access
      respond_to :json, :xml

      def index
        respond_with Resource.all
      end

      def show
        respond_with Resource.find(params[:id])
      end

      def create
        respond_with Resource.create(params[:resource])
      end

      def update
        respond_with Resource.update(params[:id], params[:resource])
      end

      def destroy
        respond_with Resource.destroy(params[:id])
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
