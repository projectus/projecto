require 'test_helper'

class UserRequestInfoControllerTest < ActionController::TestCase
  test "should get applications" do
    get :applications
    assert_response :success
  end

  test "should get invitations" do
    get :invitations
    assert_response :success
  end

end
