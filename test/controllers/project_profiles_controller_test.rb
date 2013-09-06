require 'test_helper'

class ProjectProfilesControllerTest < ActionController::TestCase
  setup do
    @project_profile = project_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_profile" do
    assert_difference('ProjectProfile.count') do
      post :create, project_profile: { Project_id: @project_profile.Project_id, outline_xml: @project_profile.outline_xml, project_id: @project_profile.project_id }
    end

    assert_redirected_to project_profile_path(assigns(:project_profile))
  end

  test "should show project_profile" do
    get :show, id: @project_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_profile
    assert_response :success
  end

  test "should update project_profile" do
    patch :update, id: @project_profile, project_profile: { Project_id: @project_profile.Project_id, outline_xml: @project_profile.outline_xml, project_id: @project_profile.project_id }
    assert_redirected_to project_profile_path(assigns(:project_profile))
  end

  test "should destroy project_profile" do
    assert_difference('ProjectProfile.count', -1) do
      delete :destroy, id: @project_profile
    end

    assert_redirected_to project_profiles_path
  end
end
