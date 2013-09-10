class CollaborationsController < ApplicationController
  before_action :set_collaboration, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:index]
	before_action(except: [:index, :destroy, :show]) do 
	  authenticate_current_user_as_project_owner(@project||=@collaboration.project, 
	                       "You don't have the permissions to modify this collaboration.")
	end
  before_action :authenticate_current_user_as_collaborator_or_owner, only: [:destroy]

  # GET /collaborations
  # GET /collaborations.json
  def index
    @collaborations = @project.collaborations
  end
	
  # GET /collaborations/1
  # GET /collaborations/1.json
  def show	
  end

  # GET /collaborations/new
  #def new
  #  @collaboration = Collaboration.new
  #end

  # GET /collaborations/1/edit
  def edit
  end

  # POST /collaborations
  # POST /collaborations.json
  #def create
  #  @collaboration = Collaboration.new(collaboration_params)

  #  respond_to do |format|
  #    if @collaboration.save
  #      format.html { redirect_to @collaboration, notice: 'Collaboration was successfully created.' }
  #      format.json { render action: 'show', status: :created, location: @collaboration }
  #    else
  #      format.html { render action: 'new' }
  #      format.json { render json: @collaboration.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PATCH/PUT /collaborations/1
  # PATCH/PUT /collaborations/1.json
  def update	
    respond_to do |format|
      if @collaboration.update(params.require(:collaboration).permit(:role))
        format.html { redirect_to @collaboration, notice: 'Collaboration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @collaboration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collaborations/1
  # DELETE /collaborations/1.json
  def destroy
	  project = @collaboration.project
    @collaboration.destroy
    respond_to do |format|
      format.html { redirect_to project_collaborations_url(project) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collaboration
      @collaboration = Collaboration.find(params[:id])
    end

    def set_project
	    @project = Project.find(params[:project_id])
	  end
		
	  # Authenticate the signed in user as the project owner or collaborator in question
    def authenticate_current_user_as_collaborator_or_owner
	    unless @collaboration.project.owned_by?(current_user)
		    unless @collaboration.user == current_user
	        flash[:alert] = "You don't have the permissions to delete this collaboration"
	        redirect_to :back
	      end
	    end
	  end
    # Never trust parameters from the scary internet, only allow the white list through.
    #def collaboration_params
    #  params.require(:collaboration).permit(:role, :user_id, :project_id)
    #end
end
