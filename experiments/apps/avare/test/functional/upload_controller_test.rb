require 'test_helper'

class UploadControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get file_upload" do
    get :file_upload
    assert_response :success
  end

end
