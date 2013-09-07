class CollaborationApplicationsController < ApplicationController
	# See the bottom of this controller for the definitions of these methods
  before_action :set_collaboration_application, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
  before_action :check_current_user_is_project_owner, only: [:edit, :update]
  before_action :check_application_active, only: [:edit, :update]
  before_action :check_application_pending, only: [:edit, :update]

  # GET /collaboration_applications
  # GET /collaboration_applications.json
  def index
    @collaboration_applications = CollaborationApplication.all
  end

  # GET /collaboration_applications/1
  # GET /collaboration_applications/1.json
  def show
  end

  # GET /projects/:project_id/application/new
  def new
	  project = Project.find(params[:project_id])
  		
	  # Check that the user is not already collaborating on this project. Move this to model?
	  if current_user.is_collaborating_on_project?(project)
		  redirect_to project, alert: 'You are already collaborating on this project.'
		  return
		end

	  # Check that the user does not already have active application. Move this to model?
	  if current_user.has_pending_application_to_project?(project)
		  redirect_to project, alert: 'You already have a pending application to this project.'
		  return
		end
		
		# Check that the user does not already have active invitation. Move this to model?
	  if current_user.has_pending_invitation_to_project?(project)
		  redirect_to project, alert: 'You already have a pending invitation to this project.'
		  return
		end
				
    @collaboration_application = CollaborationApplication.new		
    @collaboration_application.project = project
  end

  # GET /collaboration_applications/1/edit
  def edit
  end

  # POST /collaboration_applications
  # POST /collaboration_applications.json
  def create   
    project = Project.find(params[:collaboration_application][:project_id])
    message = params[:collaboration_application][:message]
    @collaboration_application = CollaborationApplication.new(project: project, message: message)
		@collaboration_application.user = current_user
		
    respond_to do |format|
      if @collaboration_application.save
        format.html { redirect_to @collaboration_application, notice: 'Application was successfully created.' }
        format.json { render action: 'show', status: :created, location: @collaboration_application }
      else
        format.html { render action: 'new' }
        format.json { render json: @collaboration_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collaboration_applications/1
  # PATCH/PUT /collaboration_applications/1.json
  def update
    respond_to do |format|
	    permitted_params = params.require(:collaboration_application).permit(:status)
      if @collaboration_application.update(permitted_params)
	      @collaboration_application.cash_in
        format.html { redirect_to @collaboration_application, notice: "Application was successfully #{@collaboration_application.status}." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @collaboration_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collaboration_applications/1
  # DELETE /collaboration_applications/1.json
  #def destroy
  #  @collaboration_application.destroy
  #  respond_to do |format|
  #    format.html { redirect_to collaboration_applications_url }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collaboration_application
      @collaboration_application = CollaborationApplication.find(params[:id])
    end

    # Authenticate the signed in user as the project owner
    def check_current_user_is_project_owner
	    project = @collaboration_application.project
	    unless current_user == project.owner
	      flash[:alert] = "You don't have the permissions to make changes to this project"
	      redirect_to :back
	    end
	  end

    # Only allow active applications to be accepted or denied.
    def check_application_active
	    unless @collaboration_application.active == 'yes'
		    flash[:alert] = 'This application is not active.'
		    redirect_to :back
		  end
	  end
	
    # Only allow pending applications to be accepted or denied.
    def check_application_pending
	    unless @collaboration_application.status == 'pending'
		    flash[:alert] = "This application has already been #{@collaboration_application.status}"
		    redirect_to :back
		  end
	  end
end
