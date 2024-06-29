# app/controllers/chats_controller.rb
class ChatsController < ApplicationController
  before_action :set_application

  # GET /applications/:application_token/chats
  def index
    @chats = @application.chats
    render json: @chats
  end

  # POST /applications/:application_token/chats
  def create
    last_chat = @application.chats.order(:number).last
    chat_number = last_chat.present? ? last_chat.number + 1 : 1

    SaveChatJob.set(wait: 10.seconds).perform_later(@application.id, chat_number) # Adding a delay of 10 seconds
    render json: { message: 'Chat is being processed' }, status: :accepted
  end

  # GET /applications/:application_token/chats/:number
  def show
    @chat = @application.chats.find_by(number: params[:number])
    if @chat
      render json: @chat
    else
      render json: { error: 'Chat not found' }, status: :not_found
    end
  end

  private

  def set_application
    @application = Application.find_by(token: params[:application_token])
    render json: { error: 'Application not found' }, status: :not_found unless @application
  end
end
