class TaskGroupsController < ApplicationController
  before_action :set_task_group, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:create, :new]

  # Authenticate current user as project owner.
  before_action(except: [:index, :show]) do
	  authenticate_current_user_as_project_owner(associated_project, 
	                       "You don't have the permissions to modify task groups.")
	end
	
  # GET /projects/1/task_groups
  # GET /projects/1/task_groups.json
  def index
	  @project = Project.includes(:task_groups).find(params[:project_id])
    @task_groups = @project.task_groups
  end

  # GET /task_groups/1
  # GET /task_groups/1.json
  def show
	  @task = Task.new
	  @task.task_group_id = params[:id]
  end

  # GET /projects/1/task_groups/new
  def new
    @task_group = TaskGroup.new
    @task_group.project_id = params[:project_id]
  end

  # GET /task_groups/1/edit
  def edit
  end

  # POST /task_groups
  # POST /task_groups.json
  def create
    @task_group = TaskGroup.new(task_group_params)

    respond_to do |format|
      if @task_group.save
        format.html { redirect_to @task_group, notice: 'Task group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @task_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_groups/1
  # PATCH/PUT /task_groups/1.json
  def update
    respond_to do |format|
      if @task_group.update(task_group_params)
        format.html { redirect_to @task_group, notice: 'Task group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_groups/1
  # DELETE /task_groups/1.json
  def destroy
	  project = @task_group.project
    @task_group.destroy
    respond_to do |format|
      format.html { redirect_to project_task_groups_url(project) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_group
      @task_group = TaskGroup.find(params[:id])
    end
	
   def set_project
	   @project = Project.find(params[:project_id]||=task_group_params[:project_id])
	 end
	 
   # Never trust parameters from the scary internet, only allow the white list through.
    def task_group_params
      params.require(:task_group).permit(:name, :project_id)
    end

    def associated_project
	    @project ||= @task_group.project 
	  end
end
