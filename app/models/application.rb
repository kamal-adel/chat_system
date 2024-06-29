class Application < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  before_create :generate_token
  has_many :chats, dependent: :destroy
  validates :name, presence: true

  private

  def generate_token
    self.token = SecureRandom.hex(10)
  end

  # Customize the JSON serialization for Elasticsearch
  def as_indexed_json(options = {})
    as_json(only: [:token, :name])
  end
end

# Ensure the Elasticsearch index is created for Application
Application.__elasticsearch__.create_index! force: true
Application.import
