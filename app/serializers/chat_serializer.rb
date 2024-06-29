# app/serializers/chat_serializer.rb
class ChatSerializer < ActiveModel::Serializer
  attributes :id, :number, :application_token, :created_at, :updated_at

  def application_token
    object.application.token
  end
end
