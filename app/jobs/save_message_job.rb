# app/jobs/save_message_job.rb
class SaveMessageJob < ApplicationJob
    queue_as :default
  
    retry_on ActiveRecord::RecordInvalid, wait: 5.seconds, attempts: 5
  
    def perform(chat_id, body, number)
      chat = Chat.find(chat_id)
      message = chat.messages.new(body: body, number: number)
  
      if message.save
        message.__elasticsearch__.index_document
        Rails.logger.info "Message #{message.id} saved and indexed successfully."
      else
        Rails.logger.error "Failed to save message: #{message.errors.full_messages.join(', ')}"
        raise ActiveRecord::RecordInvalid.new(message) # Raising an error to trigger retry
      end
    end
  end
  