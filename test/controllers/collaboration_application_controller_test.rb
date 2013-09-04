require 'test_helper'

class CollaborationApplicationControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get accept" do
    get :accept
    assert_response :success
  end

  test "should get deny" do
    get :deny
    assert_response :success
  end

end
