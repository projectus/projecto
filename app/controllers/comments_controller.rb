class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index]
  before_action :authenticate_comment_belongs_to_current_user, only: [:edit, :update, :destroy]

  helper_method :associated_project

  # GET /comments
  # GET /comments.json
  def index
	  @project = Project.find(params[:project_id])
    @comments = @project.comments
    @comment = Comment.new
    @comment.project = @project
  end

  # GET projects/1/comments/new
  #def new
  #  @comment = Comment.new
  #  @comment.project_id = params[:project_id]
  #end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_comments_url(@comment.project), notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to project_comments_url(@comment.project), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
	  project = @comment.project
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to project_comments_url(project) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :project_id)
    end

    # Authenticate the signed in user as the one who wrote the comment
    def authenticate_comment_belongs_to_current_user
	    unless @comment.user == current_user
	      redirect_to :back, alert: "This comment doesn't belong to you!"
	    end
	  end
	
	  def associated_project
		  @project ||= @comment.project
		end
end
