# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :set_chat

  # GET /applications/:application_token/chats/:chat_number/messages
  def index
    @messages = @chat.messages
    render json: @messages
  end

  # POST /applications/:application_token/chats/:chat_number/messages
  def create
    last_message = @chat.messages.order(:number).last
    message_number = last_message.present? ? last_message.number + 1 : 1
    message_body = message_params[:body]

    if message_body.present?
      SaveMessageJob.set(wait: 20.seconds).perform_later(@chat.id, message_body, message_number) # Adding a delay of 10 seconds
      render json: { message: 'Message is being processed' }, status: :accepted
    else
      render json: { error: 'Message body cannot be blank' }, status: :unprocessable_entity
    end
  end

  # GET /applications/:application_token/chats/:chat_number/messages/search?q=query
  def search
    query = params[:query]
    search_results = Message.search(query: {
      bool: {
        must: [
          { match: { chat_id: @chat.id } },
          { wildcard: { body: "*#{query}*" } }
        ]
      }
    }).records

    render json: search_results
  end

  private

  def set_chat
    @application = Application.find_by(token: params[:application_token])

    unless @application
      render json: { error: 'Application not found' }, status: :not_found
      return
    end

    @chat = @application.chats.find_by(number: params[:chat_number])

    unless @chat
      render json: { error: 'Chat not found' }, status: :not_found
    end
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
