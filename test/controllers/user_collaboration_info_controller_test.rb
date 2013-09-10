require 'test_helper'

class UserCollaborationInfoControllerTest < ActionController::TestCase
  test "should get collaborations" do
    get :collaborations
    assert_response :success
  end

  test "should get applications" do
    get :applications
    assert_response :success
  end

  test "should get invitations" do
    get :invitations
    assert_response :success
  end

end
