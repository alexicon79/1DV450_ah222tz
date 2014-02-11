module Api
  module V1
    class ResourcesController < FilteredResourcesController
      #before_filter :restrict_access
      respond_to :json

      def index
        apply_filters

        if filters_are_set
          @resources = get_filtered_resources
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

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end

    end
  end
end
