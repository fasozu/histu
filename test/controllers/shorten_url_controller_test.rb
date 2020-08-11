require 'test_helper'

class ShortenUrlControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shorten_url_index_url
    assert_response :success
  end

end
