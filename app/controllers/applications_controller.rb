class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :update]

  # POST /applications
  def create
    @application = Application.new(application_params)

    if @application.save
      @application.__elasticsearch__.index_document
      render json: { token: @application.token, name: @application.name }, status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  # GET /applications/:token
  def show
    render json: @application
  end

  # PATCH /applications/:token
  def update
    if @application.update(application_params)
      @application.__elasticsearch__.update_document
      render json: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  private

  def set_application
    @application = Application.find_by(token: params[:token])
  end

  def application_params
    params.require(:application).permit(:name)
  end
end
