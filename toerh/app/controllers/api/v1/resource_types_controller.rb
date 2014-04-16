module Api
  module V1
    class ResourceTypesController < ApiController

      def index
        @resource_types = ResourceType.order('id ASC')
      end

      def show
        @resource_type = ResourceType.find_by_id(params[:id])

        if !@resource_type.present?
          respond_to do |format|
            format.json { render json: "Resource type not found", status: 404 }
            format.xml { render xml: "Resource type not found", status: 404 }
          end
        end

      end

      def create
        @resource_type = ResourceType.new(params[:resource_type])
        respond_to do |format|
          if @resource_type.save
            format.json { render json: "Resource type has been added", status: :created }
            format.xml { render xml: "Resource type has been added", status: :created }
          else
            format.json { render json: @resource_type.errors, status: :unprocessable_entity }
            format.xml { render xml: @resource_type.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        @resource_type = ResourceType.find_by_id(params[:id])
        respond_to do |format|
          if @resource_type.update_attributes(params[:resource_type])
            format.json { render json: "Resource type has been updated", status: 200 }
            format.xml { render xml: "Resource type has been updated", status: 200 }
          else
            format.json { render json: @resource_type.errors, status: :unprocessable_entity }
            format.xml { render xml: @resource_type.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @resource_type = ResourceType.find_by_id(params[:id])
        @resource_type.destroy
        respond_to do |format|
          format.json { render json: "Resource type has been deleted", status: 200 }
        end
      end

      def resource_type_resources
        @resources = ResourceType.find_by_id(params[:id]).resources
      end

    end
  end
end
