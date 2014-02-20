module Api
  module V1
    class ResourcesController < FilteredResourcesController
      #before_filter :restrict_access #only allow requests with API-key
      skip_before_filter :verify_authenticity_token
      before_filter :http_basic_authenticate, :except => [:index, :show] #user auth to post, create, delete
      respond_to :xml, :json

      def index
        apply_filters

        #get filtered resources if filters are set
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
        @resource = Resource.find_by_id(params[:id])

        if !@resource.present?
          respond_to do |format|
            format.json { render json: "Resource not found", status: 404 }
            format.xml { render xml: "Resource not found", status: 404 }
          end
        end

      end

      def create
        @resource = Resource.new(params[:resource])
        append_tags
        respond_to do |format|
          if @resource.save
            format.json { render json: "Resource has been added", status: :created }
            format.xml { render xml: "Resource has been added", status: :created }
          else
            format.json { render json: @resource.errors, status: :unprocessable_entity }
            format.xml { render xml: @resource.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        @resource = Resource.find_by_id(params[:id])
        respond_to do |format|
          if @resource.update_attributes(params[:resource])
            format.json { render json: "resource has been updated", status: 200 }
            format.xml { render xml: "resource has been updated", status: 200 }
          else
            format.json { render json: @resource.errors, status: :unprocessable_entity }
            format.xml { render xml: @resource.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @resource = Resource.find_by_id(params[:id])
        @resource.destroy
        respond_to do |format|
          format.json { render json: "Resource has been deleted", status: 200 }
        end
      end

    private

      def append_tags
        tags = []
        tags = params[:tag]
        if tags
          tags.each do |tag_name|
            tag = Tag.create({tag_name: tag_name})
            @resource.tags << tag
          end
        end
      end

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
