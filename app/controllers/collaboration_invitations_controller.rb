class CollaborationInvitationsController < ApplicationController
	before_action :authenticate_user!
  before_action :set_collaboration_invitation, only: [:show, :update, :destroy]
	before_action :check_has_owned_projects, only: [:new]
	before_action :authenticate_current_user_as_invited_user, only: [:update]
	before_action(only: [:create]) do
		project = Project.find(invitation_params[:project_id]) 
	  authenticate_current_user_as_project_owner(project, 
	                       "You don't have the permissions to invite to this project.")
	end
	
  # GET /collaboration_invitations
  # GET /collaboration_invitations.json
  #def index
  #  @collaboration_invitations = CollaborationInvitation.all
  #end
	
  # GET /collaboration_invitations/1
  # GET /collaboration_invitations/1.json
  def show
	  @user = @collaboration_invitation.invited_user
    @user_profile = @user.user_profile
  end

  # GET /projects/:project_id/users/:user_id/invitation/new
  def new
	  @collaboration_invitation = CollaborationInvitation.new
	  @user = User.find(params[:user_id])
	  @user_profile = @user.user_profile
    @collaboration_invitation.invited_user = @user
  end

  # POST /collaboration_invitations
  # POST /collaboration_invitations.json
  def create
	  @collaboration_invitation = current_user.sent_collaboration_invitations.build(invitation_params)

    @user = @collaboration_invitation.invited_user
    @user_profile = @user.user_profile
		
    respond_to do |format|
      if @collaboration_invitation.save
        format.html { redirect_to @collaboration_invitation, notice: 'Collaboration invitation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @collaboration_invitation }
      else
        format.html { render action: 'new' }
        format.json { render json: @collaboration_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collaboration_invitations/1
  # PATCH/PUT /collaboration_invitations/1.json
  def update
    respond_to do |format|
			# Update status of the invitation only
	    status_param = params.require(:collaboration_invitation).permit(:status)
	
	    @user = @collaboration_invitation.invited_user
	    @user_profile = @user.user_profile
	
      if @collaboration_invitation.update(status_param)	
        format.html { redirect_to user_collaboration_invitations_path(@user), notice: "Invitation was successfully #{@collaboration_invitation.status}." }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @collaboration_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collaboration_invitations/1
  # DELETE /collaboration_invitations/1.json
  #def destroy
  #  @collaboration_invitation.destroy
  #  respond_to do |format|
  #    format.html { redirect_to collaboration_invitations_url }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collaboration_invitation
      @collaboration_invitation = CollaborationInvitation.find(params[:id])
    end
	
    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:collaboration_invitation).permit(:project_id, :message, :invited_user_id)
    end
		
		# Redirect if current user doesn't have any projects he can invite to
    def check_has_owned_projects
	    if current_user.owned_projects.empty?
		    redirect_to :back, alert: 'You have no projects you can invite to.'
		  end
	  end
	
    # Authenticate the signed in user as the invited user
    def authenticate_current_user_as_invited_user
	    unless current_user == @collaboration_invitation.invited_user
	      redirect_to :back, alert: 'This invitation is not for you!'
	    end
	  end
end
