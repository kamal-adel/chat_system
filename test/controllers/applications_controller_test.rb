require 'test_helper'

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Clean up Elasticsearch indices
    Application.__elasticsearch__.client.indices.delete index: Application.__elasticsearch__.index_name rescue nil
    Application.__elasticsearch__.create_index! force: true
    Application.import
  end

  test "should show application" do
    application = Application.create(name: 'Test Application', token: SecureRandom.hex(10))
    get application_url(application)
    assert_response :success
  end

  # Add more tests as needed
end
