class ProjectsController < ApplicationController
	before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action(except: [:show, :index, :new, :create]) do 
	  authenticate_current_user_as_project_owner(@project, 
	          "You don't have the permissions to modify this project.")
	end

  def index
	  if params[:cat]
	    @projects = Project.find_all_by_category(params[:cat].downcase)
    elsif params[:tag]
	    @projects = Project.tagged_with_something_like(params[:tag])
	  else
	    @projects = Project.all
    end

    respond_to do |format|
      format.html
    end
  end

  def show
     @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def edit
	  @avatar_image = @project.profile.avatar.gallery_image
  end
	
  def create
    @project = current_user.owned_projects.build(project_params)

    respond_to do |format|
      if @project.save	
        format.html { redirect_to @project.profile, notice: "Project was successfully created!" }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
	  image_id = params[:avatar][:image_id]
	  unless image_id.empty?
	    gi = GalleryImage.find(image_id)
	    @project.profile.avatar.update_image(gi)
    end
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project.profile, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy		
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Successfully deleted project.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :category, :tag_list, :description)
    end
end
