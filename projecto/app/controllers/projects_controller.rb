class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authenticate_current_user_as_project_owner, except: [:show, :index, :new, :create]

  # GET /projects
  # GET /projects.json
  def index
	  if params[:tag]
	    @projects = Project.tagged_with(params[:tag])
	  else
	    @projects = Project.all
	  end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
	      collab = Collaboration.create(role: 'owner', project: @project, user: current_user)
        format.html { redirect_to @project, notice: "Project was successfully created. Owned by #{collab.user.username}" }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update	
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
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
      format.html { redirect_to projects_url }
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
      params.require(:project).permit(:name, :category, :tag_list)
    end

    def authenticate_current_user_as_project_owner
		  if current_user.collaborations.find_by_project_id_and_role(params[:id],'owner').nil?
		    flash[:alert] = "You don't have the permissions to make changes to this project"
		    redirect_to :back
		  end
		end
end
