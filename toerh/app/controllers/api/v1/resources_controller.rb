module Api
  module V1
    class ResourcesController < FilteredResourcesController

      def index
        apply_filters

        #get filtered resources if filters are set
        if filters_are_set
          @resources = get_filtered_resources
          if @resources.size == 0
            render :status => 404
          end
        else
          @resources = Resource.order("id ASC")
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
        append_tags
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

            unless Tag.exists?(tag_name: tag_name)
              tag = Tag.create({tag_name: tag_name})
              @resource.tags << tag
            end

          end
        end
      end

    end
  end
end
