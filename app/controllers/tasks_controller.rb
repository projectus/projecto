class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_task_group_and_project, only: [:create]

  # Authenticate current user as project owner. Set project depending on the action.
  before_action(except: [:index, :show]) do
	  authenticate_current_user_as_project_owner(associated_project, 
	                       "You don't have the permissions to modify tasks.")
	end

  # GET /tasks
  # GET /tasks.json
  def index
	  @project = Project.includes(task_groups: :tasks).find(params[:project_id])
    @tasks = @project.tasks
    @task = Task.new
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET task_groups/1/tasks/new
  #def new
  #  @task = @task_group.tasks.build
    #@task.task_group_id = params[:task_group_id]
  #end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @task_group.tasks.build(task_params)
    @task.poster = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_tasks_url(@project), notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'task_groups/index' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
	  project = @task.task_group.project
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_url(project) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_task_group_and_project
	    @task_group = TaskGroup.includes(:project).find(params[:task][:task_group_id])
	    @project = @task_group.project
	  end
			
    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :details, :priority)
    end

    def associated_project
	    @project ||= @task.task_group.project 
	  end
end
