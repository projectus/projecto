require 'test_helper'

class CollaborationApplicationsControllerTest < ActionController::TestCase
  setup do
    @collaboration_application = collaboration_applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:collaboration_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create collaboration_application" do
    assert_difference('CollaborationApplication.count') do
      post :create, collaboration_application: {  }
    end

    assert_redirected_to collaboration_application_path(assigns(:collaboration_application))
  end

  test "should show collaboration_application" do
    get :show, id: @collaboration_application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @collaboration_application
    assert_response :success
  end

  test "should update collaboration_application" do
    patch :update, id: @collaboration_application, collaboration_application: {  }
    assert_redirected_to collaboration_application_path(assigns(:collaboration_application))
  end

  test "should destroy collaboration_application" do
    assert_difference('CollaborationApplication.count', -1) do
      delete :destroy, id: @collaboration_application
    end

    assert_redirected_to collaboration_applications_path
  end
end
