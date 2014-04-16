module Api
  module V1
    class LicencesController < ApiController

      def index
        @licences = Licence.order('id ASC')
      end

      def show
        @licence = Licence.find_by_id(params[:id])

        if !@licence.present?
          respond_to do |format|
            format.json { render json: "Licence not found", status: 404 }
            format.xml { render xml: "Licence not found", status: 404 }
          end
        end

      end

      def create
        @licence = Licence.new(params[:licence])
        respond_to do |format|
          if @licence.save
            format.json { render json: "licence has been added", status: :created }
            format.xml { render xml: "licence has been added", status: :created }
          else
            format.json { render json: @licence.errors, status: :unprocessable_entity }
            format.xml { render xml: @licence.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        @licence = Licence.find_by_id(params[:id])
        respond_to do |format|
          if @licence.update_attributes(params[:licence])
            format.json { render json: "licence has been updated", status: 200 }
            format.xml { render xml: "licence has been updated", status: 200 }
          else
            format.json { render json: @licence.errors, status: :unprocessable_entity }
            format.xml { render xml: @licence.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @licence = Licence.find_by_id(params[:id])
        @licence.destroy
        respond_to do |format|
          format.json { render json: "licence has been deleted", status: 200 }
        end
      end

      def licence_resources
        @resources = Licence.find_by_id(params[:id]).resources
      end

    end
  end
end
