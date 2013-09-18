class NewsPostsController < ApplicationController
  before_action :set_news_post, only: [:show, :edit, :update, :destroy]

  # GET /news_posts
  # GET /news_posts.json
  def index
    @news_post = NewsPost.new
    @news_post.project_id = params[:project_id]
    @news_posts = associated_project.news
  end

  # GET /news_posts/1
  # GET /news_posts/1.json
  def show
  end

  # GET /news_posts/new
  #def new
  #  @news_post = NewsPost.new
  #  @news_post.project_id = params[:project_id]
  #end

  # GET /news_posts/1/edit
  def edit
  end

  # POST /news_posts
  # POST /news_posts.json
  def create
    #@news_post = NewsPost.new(news_post_params)
    @news_post = current_user.news.build(news_post_params)
    @news_post.species = 'regular'

    respond_to do |format|
      if @news_post.save
        format.html { redirect_to @news_post.project.profile, notice: 'News post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @news_post }
      else
        format.html { render action: 'show' }
        format.json { render json: @news_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news_posts/1
  # PATCH/PUT /news_posts/1.json
  def update
    respond_to do |format|
      if @news_post.update(news_post_params)
        format.html { redirect_to @news_post, notice: 'News post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @news_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_posts/1
  # DELETE /news_posts/1.json
  def destroy
	  project_id = @news_post.project_id
    @news_post.destroy
    respond_to do |format|
      format.html { redirect_to project_news_posts_url(project_id) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_post
      @news_post = NewsPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_post_params
      params.require(:news_post).permit(:content, :title, :project_id)
    end

	  def associated_project
		  @news_post.project
		end
end
