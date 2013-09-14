require 'test_helper'

class NewsPostsControllerTest < ActionController::TestCase
  setup do
    @news_post = news_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:news_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create news_post" do
    assert_difference('NewsPost.count') do
      post :create, news_post: { content: @news_post.content, project_id: @news_post.project_id, title: @news_post.title, type: @news_post.type, user_id: @news_post.user_id }
    end

    assert_redirected_to news_post_path(assigns(:news_post))
  end

  test "should show news_post" do
    get :show, id: @news_post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @news_post
    assert_response :success
  end

  test "should update news_post" do
    patch :update, id: @news_post, news_post: { content: @news_post.content, project_id: @news_post.project_id, title: @news_post.title, type: @news_post.type, user_id: @news_post.user_id }
    assert_redirected_to news_post_path(assigns(:news_post))
  end

  test "should destroy news_post" do
    assert_difference('NewsPost.count', -1) do
      delete :destroy, id: @news_post
    end

    assert_redirected_to news_posts_path
  end
end
