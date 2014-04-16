module Api
  module V1
    class UsersController < ApiController

      def index
        @users = User.order('id ASC')
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

    end
  end
end
