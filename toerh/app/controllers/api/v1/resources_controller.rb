module Api
  module V1
    class ResourcesController < FilteredResourcesController
      #before_filter :restrict_access
      skip_before_filter :verify_authenticity_token
      before_filter :http_basic_authenticate, :except => [:index, :show]
      respond_to :xml, :json

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

        respond_to do |format|
          if @resource.save
            append_tags

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
        #if params[:tags].respond_to?('each')
          params[:tags].each do |tag_name|
            tag_name.downcase!
            @resource.tags << get_tag(tag_name)
          end
        #end
      end

      def get_tag(tag_name)
        #Tag.find_by_tag_name(tag_name) || Tag.create(tag_name: tag_name)
        Tag.create(tag_name: tag_name)
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
