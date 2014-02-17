module Api
  module V1
    class ResourcesController < FilteredResourcesController
      #before_filter :restrict_access
      #http_basic_authenticate_with name: "dhh", password: "secret", except: :index
      before_filter :http_basic_authenticate, :except => [:index]
      #respond_to :xml

      def index
        apply_filters

        if filters_are_set
          @resources = get_filtered_resources
          if @resources.size == 0
            render :status => 404
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

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end

      def http_basic_authenticate
        authenticate_or_request_with_http_basic do |username, password|
          @user = User.find_by_username(username)
          @user.authenticate(password)
        end
      end

    end
  end
end
