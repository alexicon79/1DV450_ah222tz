module Api
  module V1
    class UsersController < ApplicationController

      def index
        @users = User.all
      end

      def show
        @user = User.find(params[:id])
      end

      def user_resources
        @resources = User.find(params[:id]).resources
      end
    end
  end
end
