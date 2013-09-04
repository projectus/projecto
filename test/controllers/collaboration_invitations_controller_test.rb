require 'test_helper'

class CollaborationInvitationsControllerTest < ActionController::TestCase
  setup do
    @collaboration_invitation = collaboration_invitations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:collaboration_invitations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create collaboration_invitation" do
    assert_difference('CollaborationInvitation.count') do
      post :create, collaboration_invitation: {  }
    end

    assert_redirected_to collaboration_invitation_path(assigns(:collaboration_invitation))
  end

  test "should show collaboration_invitation" do
    get :show, id: @collaboration_invitation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @collaboration_invitation
    assert_response :success
  end

  test "should update collaboration_invitation" do
    patch :update, id: @collaboration_invitation, collaboration_invitation: {  }
    assert_redirected_to collaboration_invitation_path(assigns(:collaboration_invitation))
  end

  test "should destroy collaboration_invitation" do
    assert_difference('CollaborationInvitation.count', -1) do
      delete :destroy, id: @collaboration_invitation
    end

    assert_redirected_to collaboration_invitations_path
  end
end
