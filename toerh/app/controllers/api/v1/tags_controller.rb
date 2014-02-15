module Api
  module V1
    class TagsController < ApplicationController

      def index
        @tags = Tag.all
      end

      def show
        @tag = Tag.find(params[:id])
      end

      def tag_resources
        @resources = Tag.find(params[:id]).resources
      end

    end
  end
end
