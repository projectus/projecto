class CollaborationApplicationController < ApplicationController
	before_action :set_application_and_project, only: [:show, :accept, :deny]
	before_action :authenticate_user!
  before_action :authenticate_current_user_as_project_owner, except: [:show, :create]

  def show
	end
	  
  def create
	  @project = Project.find(params[:project_id])
	
	  # Check that the user is not already collaborating on this project
	  unless current_user.collaborations.find_by_project_id(@project).nil?
		  redirect_to @project, alert: 'You are already collaborating on this project.'
		  return
		end
		
	  @application = CollaborationApplication.new(user: current_user, project: @project)

    respond_to do |format|
      if @application.save
        format.html { redirect_to @project, notice: "Successfully applied to #{@project.name}" }	
      else
        format.html { render action: 'application_errors' }
        format.json { render json: @application.errors, status: :unprocessable_entity }    
      end
    end
  end

  def accept
	  @collaboration = Collaboration.new(user: @application.user, role: 'peasant', project: @project)
    @application.destroy

    respond_to do |format|
      if @collaboration.save
        format.html { redirect_to @collaboration, notice: "#{@application.user.username} has been successfully added to #{@project.name}" }	
      else
        format.html { render action: 'accept' }
        format.json { render json: @collaboration.errors, status: :unprocessable_entity }    
      end
    end	  
  end

  def deny
	  user = @application.user
    @application.destroy
    redirect_to @project, notice: "#{user.username} has been denied from #{@project.name}"		
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application_and_project
      @application = CollaborationApplication.find(params[:id])
      @project = @application.project
    end

    def authenticate_current_user_as_project_owner
	    if current_user.collaborations.find_by_project_id_and_role(@project,'owner').nil?
	      flash[:alert] = "You don't have the permissions to make changes to this project"
	      redirect_to :back
	    end
	  end
end
