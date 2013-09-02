require 'test_helper'

class CollaborationsControllerTest < ActionController::TestCase
  setup do
    @collaboration = collaborations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:collaborations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create collaboration" do
    assert_difference('Collaboration.count') do
      post :create, collaboration: { project_id: @collaboration.project_id, role: @collaboration.role, user_id: @collaboration.user_id }
    end

    assert_redirected_to collaboration_path(assigns(:collaboration))
  end

  test "should show collaboration" do
    get :show, id: @collaboration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @collaboration
    assert_response :success
  end

  test "should update collaboration" do
    patch :update, id: @collaboration, collaboration: { project_id: @collaboration.project_id, role: @collaboration.role, user_id: @collaboration.user_id }
    assert_redirected_to collaboration_path(assigns(:collaboration))
  end

  test "should destroy collaboration" do
    assert_difference('Collaboration.count', -1) do
      delete :destroy, id: @collaboration
    end

    assert_redirected_to collaborations_path
  end
end
