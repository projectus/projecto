class CollaborationInvitationsController < ApplicationController
	before_action :authenticate_user!
  before_action :set_invitation, only: [:show, :update]
	before_action :authenticate_current_user_as_invited_user, only: [:update]
	before_action(only: [:create]) do
		project = Project.find(invitation_params[:project_id]) 
	  authenticate_current_user_as_project_owner(project, 
	                       "You don't have the permissions to invite to this project.")
	end
	
  # GET /collaboration_invitations/1
  # GET /collaboration_invitations/1.json
  def show
  end

  # POST /collaboration_invitations
  # POST /collaboration_invitations.json
  def create
	  @invitation = current_user.sent_collaboration_invitations.build(invitation_params)
		
    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @invitation, notice: 'Invitation was sent successfully.' }
      else
        format.html { render partial: 'errors' }
      end
    end
  end

  # PATCH/PUT /collaboration_invitations/1
  # PATCH/PUT /collaboration_invitations/1.json
  def update
    respond_to do |format|
			# Update status of the invitation only
	    status_param = params.require(:collaboration_invitation).permit(:status)
	
      if @invitation.update(status_param)	
        format.html { redirect_to user_invitations_path(@invitation.invited_user), notice: "Invitation was successfully #{@invitation.status}." }
      else
        format.html { render action: 'show' }
      end
    end
  end
		
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = CollaborationInvitation.find(params[:id])
    end

    def associated_user
      @invitation.invited_user
	  end
			
    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.permit(:project_id, :message, :invited_user_id)
    end
	
    # Authenticate the signed in user as the invited user
    def authenticate_current_user_as_invited_user
	    unless current_user == @invitation.invited_user
	      redirect_to :back, alert: 'This invitation is not for you!'
	    end
	  end
end
