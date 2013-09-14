class CollaborationApplicationsController < ApplicationController
	# See the bottom of this controller for the definitions of these methods
  before_action :set_application, only: [:show, :update]
	before_action :authenticate_user!
	before_action(only: [:update]) do 
	  authenticate_current_user_as_project_owner(@application.project, 
	                       "You don't have the permissions to accept or decline this application.")
	end

  # GET /collaboration_applications/1
  # GET /collaboration_applications/1.json
  def show
  end

  # GET /projects/1/application/new
  def new
    @application = CollaborationApplication.new		
    @application.project_id = params[:project_id]
  end

  # POST /collaboration_applications
  # POST /collaboration_applications.json
  def create
		@application = current_user.collaboration_applications.build(application_params)
		
    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, notice: 'Application was successfully created.' }
        format.json { render action: 'show', status: :created, location: @application }
      else
        format.html { render action: 'new' }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collaboration_applications/1
  # PATCH/PUT /collaboration_applications/1.json
  def update
    respond_to do |format|
	    status_param = params.require(:collaboration_application).permit(:status)
	
      if @application.update(status_param)
        format.html { redirect_to @application, notice: "Application was successfully #{@application.status}." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = CollaborationApplication.find(params[:id])
    end

    def associated_project
      @application.project
	  end
	
    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:collaboration_application).permit(:project_id, :message)
    end
end
