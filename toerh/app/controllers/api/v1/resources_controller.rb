module Api
  module V1
    class ResourcesController < ApplicationController
      #before_filter :restrict_access
      respond_to :json

      def index
        if params[:filter] == "true"
          filter = set_optional_filter
          case filter
          when "user"
            @resources = get_resources_by_user_id
          when "licence"
            @resources = get_resources_by_licence_id
          when "tag"
            @resources = get_resources_by_tag_id
          end
        else
          @resources = Resource.all
        end
      end

      def show
        @resource = Resource.find(params[:id])
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

      def get_resources_by_user_id
        # return resources if param value is a number less than total amount of users
        if params[:user].to_i <= User.all.count && params[:user].to_i != 0
          return User.find(params[:user]).resources
        else
          return nil
        end
      end

      def get_resources_by_licence_id
        # return resources if param value is a number less than total amount of licences
        if params[:licence].to_i <= Licence.all.count && params[:licence].to_i != 0
          return Licence.find(params[:licence]).resources
        else
          return nil
        end
      end

      def get_resources_by_tag_id
        if params[:tag].to_i <= Tag.all.count && params[:tag].to_i != 0
          return Tag.find(params[:tag]).resources
        else
          return nil
        end
      end

      def get_resources_by_licence_abbr
        # todo: implement
      end

      def set_optional_filter
        if params[:user] != nil
          return "user"
        elsif params[:licence] != nil
          return "licence"
        elsif params[:tag] != nil
          return "tag"
        end
      end

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end

    end
  end
end
