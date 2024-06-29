class Chat < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :application
  has_many :messages, dependent: :destroy

  validates :number, presence: true

  # Customize the JSON serialization for Elasticsearch
  def as_indexed_json(options = {})
    as_json(only: [:number, :application_id, :messages_count])
  end
end

# Ensure the Elasticsearch index is created for Chat
Chat.__elasticsearch__.create_index! force: true
Chat.import