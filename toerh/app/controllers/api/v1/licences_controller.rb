module Api
  module V1
    class LicencesController < ApplicationController
      #before_filter :restrict_access
      skip_before_filter :verify_authenticity_token
      before_filter :http_basic_authenticate, :except => [:index, :show, :licence_resources]
      respond_to :json, :xml

      def index
        @licences = Licence.all
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
