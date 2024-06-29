class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat, counter_cache: true

  validates :body, presence: true

  # Customize the JSON serialization for Elasticsearch
  def as_indexed_json(options = {})
    as_json(only: [:body, :chat_id])
  end
end

# Ensure the Elasticsearch index is created for Message
Message.__elasticsearch__.create_index! force: true
Message.import