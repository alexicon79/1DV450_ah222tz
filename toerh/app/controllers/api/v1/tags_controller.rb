module Api
  module V1
    class TagsController < ApiController

      def index
        @tags = Tag.order('id ASC')
      end

      def show
        @tag = Tag.find_by_id(params[:id])

        if !@tag.present?
          respond_to do |format|
            format.json { render json: "Tag not found", status: 404 }
            format.xml { render xml: "Tag not found", status: 404 }
          end
        end

      end

      def create
        @tag = Tag.new(params[:tag])
        respond_to do |format|
          if @tag.save
            format.json { render json: "Tag has been added", status: :created }
            format.xml { render xml: "Tag has been added", status: :created }
          else
            format.json { render json: @tag.errors, status: :unprocessable_entity }
            format.xml { render xml: @tag.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        @tag = Tag.find_by_id(params[:id])
        respond_to do |format|
          if @tag.update_attributes(params[:tag])
            format.json { render json: "Tag has been updated", status: 200 }
            format.xml { render xml: "Tag has been updated", status: 200 }
          else
            format.json { render json: @tag.errors, status: :unprocessable_entity }
            format.xml { render xml: @tag.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @tag = Tag.find_by_id(params[:id])
        @tag.destroy
        respond_to do |format|
          format.json { render json: "Tag has been deleted", status: 200 }
        end
      end

      def tag_resources
        @resources = Tag.find(params[:id]).resources
      end

    end
  end
end
