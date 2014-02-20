module Api
  module V1
    class UsersController < ApplicationController
      #before_filter :restrict_access
      skip_before_filter :verify_authenticity_token
      before_filter :http_basic_authenticate, :except => [:index, :show, :user_resources]
      respond_to :json, :xml

      def index
        @users = User.all
      end

      def show
        @user = User.find_by_id(params[:id])

        if !@user.present?
          respond_to do |format|
            format.json { render json: "User not found", status: 404 }
            format.xml { render json: "User not found", status: 404 }
          end
        end

      end

      def create
        @user = User.new(params[:user])
        respond_to do |format|
          if @user.save
            format.json { render json: "User has been added", status: :created }
            format.xml { render xml: "User has been added", status: :created }
          else
            format.json { render json: @user.errors, status: :unprocessable_entity }
            format.xml { render xml: @user.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        @user = User.find_by_id(params[:id])
        respond_to do |format|
          if @user.update_attributes(params[:user])
            format.json { render json: "user has been updated", status: 200 }
            format.xml { render xml: "user has been updated", status: 200 }
          else
            format.json { render json: @user.errors, status: :unprocessable_entity }
            format.xml { render xml: @user.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @user = User.find_by_id(params[:id])
        @user.destroy
        respond_to do |format|
          format.json { render json: "User has been deleted", status: 200 }
        end
      end

      def user_resources
        @resources = User.find(params[:id]).resources
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
