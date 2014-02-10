module Api
  module V1
    class ResourcesController < FilteredResourcesController
      #before_filter :restrict_access
      respond_to :json

      # @@all = true
      # @@user = false
      # @@licence = false
      # @@tag = false

      # @@filter_true = "true"

      def index
        apply_filters

        if filters_are_set
          @resources = get_filtered_resources
        else
          @resources = Resource.all
        end

        # @filter_params_length = params.except(:filter, :action, :format, :controller).length


        # case filter
        #   when @@user
        #     @resources = get_resources_by_user
        #   when @@licence
        #     @resources = get_resources_by_licence
        #   when @@tag
        #     @resources = get_resources_by_tag
        #   when @@all
        #     @resources = Resource.all
        # end

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

      # def apply_filters
      #   if params[:filter].present? && params[:filter].downcase == @@filter_true
      #     if params[:user].present?
      #       @@user = true
      #     end
      #     if params[:licence].present?
      #       @@licence = true
      #     end
      #     if params[:tag].present?
      #       @@tag = true
      #     end
      #   else
      #     @@all = true
      #   end
      # end

      # def get_filtered_resources
      #   if @@all
      #     @resources = Resource.all
      #   end

      #   if @@user
      #     if @resources.nil?
      #       @resources = get_resources_by_user
      #     else
      #       @resources += get_resources_by_user
      #     end
      #   end

      #   if @@licence
      #     if @resources.nil?
      #       @resources = get_resources_by_licence
      #     else
      #       @resources += get_resources_by_licence
      #     end
      #   end

      #   if @@tag
      #     if @resources.nil?
      #       @resources = get_resources_by_tag
      #     else
      #       @resources += get_resources_by_tag
      #     end
      #   end

      #   # TODO: filter resource shown as many times as params.length
      #   # @filter_params_length

      # end

      # def get_resources_by_user
      #   # return resources if param value is a number less than total amount of users
      #   if params[:user].to_i <= User.all.count && params[:user].to_i != 0
      #     return User.find(params[:user]).resources
      #   else
      #     return nil
      #   end
      # end

      # def get_resources_by_licence
      #   # return resources if param value is a number less than total amount of licences
      #   if params[:licence].to_i <= Licence.all.count && params[:licence].to_i != 0
      #     return Licence.find(params[:licence]).resources
      #   elsif params[:licence].match(/^[a-z]+$/i)
      #     return Licence.where("lower(licence_type) = ?", params[:licence].downcase).find_each do |licence|
      #       return licence.resources
      #     end
      #   else
      #     return nil
      #   end
      # end

      # def get_resources_by_tag
      #   # return resources by tag_id if param value is a number less than total amount of tags
      #   if params[:tag].to_i <= Tag.all.count && params[:tag].to_i != 0
      #     return Tag.find(params[:tag]).resources
      #   # return resources by tag_name
      #   # TODO: check if string is not numbers...
      #   elsif params[:tag].match(/^[a-z]+$/i)
      #     return Tag.where("lower(tag_name) = ?", params[:tag].downcase).find_each do |tag|
      #       return tag.resources
      #     end
      #   else
      #     return nil
      #   end
      # end

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end

    end
  end
end
