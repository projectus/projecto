class CollaborationApplicationsController < ApplicationController
	# See the bottom of this controller for the definitions of these methods
  before_action :set_collaboration_application, only: [:show, :edit, :update]
	before_action :authenticate_user!
	before_action(only: [:edit, :update]) do 
	  authenticate_current_user_as_project_owner(@collaboration_application.project, 
	                       "You don't have the permissions to accept or decline this application.")
	end
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

  # GET /projects/1/application/new
  def new
	  project = Project.find(params[:project_id])
	  		
	  # Check that the user is not already collaborating on this project. Move this to model?
	  if current_user.is_associated_with_project?(project)
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
		@collaboration_application = current_user.collaboration_applications.build(collaboration_application_params)
		
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def collaboration_application_params
      params.require(:collaboration_application).permit(:project_id, :message)
    end
		
    # Only allow pending applications to be accepted or denied.
    def check_application_pending
	    unless @collaboration_application.status == 'pending'
		    flash[:alert] = "This application has already been #{@collaboration_application.status}"
		    redirect_to :back
		  end
	  end
end
