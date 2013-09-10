class CollaborationApplicationsController < ApplicationController
	# See the bottom of this controller for the definitions of these methods
  before_action :set_collaboration_application, only: [:show, :update]
	before_action :authenticate_user!
	before_action(only: [:update]) do 
	  authenticate_current_user_as_project_owner(@collaboration_application.project, 
	                       "You don't have the permissions to accept or decline this application.")
	end
  #before_action :check_application_pending, only: [:edit, :update]

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
    @collaboration_application = CollaborationApplication.new		
    @collaboration_application.project_id = params[:project_id]
  end

  # POST /collaboration_applications
  # POST /collaboration_applications.json
  def create
		@collaboration_application = current_user.collaboration_applications.build(application_params)
		
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
	    status_param = params.require(:collaboration_application).permit(:status)
	
      if @collaboration_application.update(status_param)
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
    def application_params
      params.require(:collaboration_application).permit(:project_id, :message)
    end
end
