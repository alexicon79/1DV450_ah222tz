class ApplicationsController < ApplicationController
  respond_to :html
  before_filter :authorize_admin, :only => :index

  #@@new_app = false


  def index
    @apps = Application.all
    respond_with @apps
  end

  def show
    #if @new_app == true
      @app = Application.find(params[:id])
      respond_with @app
    # else
    #   @app = Application.find(params[:id])
    #   @app.api_key.access_token = "hidden"
    # end
  end

  def new
    @app = Application.new
    respond_with @app
  end

  def edit
    @app = Application.find(params[:id])
  end

  def create
    @app = Application.new(params[:application])

    respond_to do |format|
      if @app.save
        @apiKey = ApiKey.create(application_id: @app.id)

        format.html { redirect_to @app, notice: @apiKey.access_token }

      else
        format.html { render action: "new" }
      end
    end
  end

  def update
  end

  def destroy
    @app = Application.find_by_id(params[:id])
    @api_key = @app.api_key

    @app.destroy
    @api_key.destroy

    respond_to do |format|
      format.html { redirect_to applications_url }
      format.json { head :no_content }
    end
  end

  protected
  def authorize_admin
  unless User.find_by_id(session[:user_id])
    redirect_to login_url, notice: "Please log in" end
  end


end
