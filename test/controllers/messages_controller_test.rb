# test/controllers/messages_controller_test.rb

require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @application = applications(:one)  # Assuming fixture data exists for Application
    @chat = chats(:one)                # Assuming fixture data exists for Chat
    @message = messages(:one)          # Assuming fixture data exists for Message
  end

  test "should get index" do
    get application_chat_messages_url(@application.token, @chat.number)
    assert_response :success

    # Optionally, you can assert the JSON response structure or content
    assert JSON.parse(response.body).length == @chat.messages.count
  end

  test "should create message" do
    assert_difference('Message.count') do
      post application_chat_messages_url(@application.token, @chat.number), params: { message: { body: 'New message body' } }
    end

    assert_response :accepted
    # Optionally, you can assert the response body or other expectations
  end

  test "should not create message with blank body" do
    assert_no_difference('Message.count') do
      post application_chat_messages_url(@application.token, @chat.number), params: { message: { body: '' } }
    end

    assert_response :unprocessable_entity
    # Optionally, you can assert the error message or other expectations
  end

  test "should search messages" do
    get search_application_chat_messages_url(@application.token, @chat.number, query: 'search term')
    assert_response :success

    # Optionally, assert the expected search results or structure of the response
    assert_not_nil assigns(:search_results)
  end

  test "should return not_found if application not found" do
    get application_chat_messages_url('invalid_token', @chat.number)
    assert_response :not_found
  end

  test "should return not_found if chat not found" do
    get application_chat_messages_url(@application.token, 'invalid_number')
    assert_response :not_found
  end

  # Add more tests as needed
end
