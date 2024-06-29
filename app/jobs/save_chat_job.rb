# app/jobs/save_chat_job.rb
class SaveChatJob < ApplicationJob
    queue_as :default
  
    retry_on ActiveRecord::RecordInvalid, wait: 5.seconds, attempts: 5
  
    def perform(application_id, chat_number)
      application = Application.find(application_id)
      chat = application.chats.new(number: chat_number)
  
      if chat.save
        chat.__elasticsearch__.index_document
        Rails.logger.info "Chat #{chat.id} saved and indexed successfully."
      else
        Rails.logger.error "Failed to save chat: #{chat.errors.full_messages.join(', ')}"
        raise ActiveRecord::RecordInvalid.new(chat) # Raising an error to trigger retry
      end
    end
  end
  