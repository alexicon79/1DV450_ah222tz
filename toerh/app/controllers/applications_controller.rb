class ApplicationsController < ApplicationController
  respond_to :html
  #before_filter :authenticate, :only => :show

  @@new_app = false


  def index
    @apps = Application.all
    respond_with @apps
  end

  def show
    if @new_app == true
      @app = Application.find(params[:id])
      respond_with @app
    else
      @app = Application.find(params[:id])
      @app.api_key.access_token = "hidden"
    end
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
  end


end
