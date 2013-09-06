class CollaborationInvitationsController < ApplicationController
  before_action :set_collaboration_invitation, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	before_action :set_invited_user, only: [:new]
	before_action :check_current_user_not_invited_user, only: [:new]
	before_action :check_current_user_is_invited_user, only: [:edit, :update]
  before_action :check_invitation_active, only: [:edit, :update]
  before_action :check_invitation_pending, only: [:edit, :update]

  # GET /collaboration_invitations
  # GET /collaboration_invitations.json
  def index
    @collaboration_invitations = CollaborationInvitation.all
  end

  # GET /collaboration_invitations/1
  # GET /collaboration_invitations/1.json
  def show
  end

  # GET /projects/:project_id/users/:user_id/invitation/new
  def new
	  @collaboration_invitation = CollaborationInvitation.new
    @collaboration_invitation.invited_user = @invited_user		
  end

  # GET /collaboration_invitations/1/edit
  def edit
  end

  # POST /collaboration_invitations
  # POST /collaboration_invitations.json
  def create
	  message = params[:collaboration_invitation][:message]
	  @collaboration_invitation = CollaborationInvitation.new(message: message)
	
		@invited_user = User.find(params[:collaboration_invitation][:invited_user_id])
	  project = Project.find(params[:collaboration_invitation][:project_id])

		@collaboration_invitation.project = project
		@collaboration_invitation.invited_user = @invited_user
			
	  # Check that the user is not already collaborating on this project. Move this to model?
	  if @invited_user.is_collaborating_on_project?(project)
		  @collaboration_invitation.errors[:base] << 'User is already collaborating on this project.'
		  render action: 'new'
		  return
		end

	  # Check that the user does not already have a pending application. Move this to model?
	  if @invited_user.has_pending_application_to_project?(project)
		  @collaboration_invitation.errors[:base] << 'This user has a pending application to this project.'
		  render action: 'new'
		  return
		end
		
		# Check that the user does not already have a pending invitation. Move this to model?
	  if @invited_user.has_pending_invitation_to_project?(project)
		  @collaboration_invitation.errors[:base] << 'This user has a pending invitation to this project.'
		  render action: 'new'
		  return
		end
		
    # Set the user which made the invitation to the current user
		@collaboration_invitation.invited_by_user = current_user
		
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
	    permitted_params = params.require(:collaboration_invitation).permit(:status)
	
      if @collaboration_invitation.update(permitted_params)	
	      # cash_in either does or doesn't create a collaboration based on the status
	      @collaboration_invitation.cash_in
	
        format.html { redirect_to @collaboration_invitation, notice: "Invitation was successfully #{@collaboration_invitation.status}." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
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

    def set_invited_user
	    @invited_user = User.find(params[:user_id])
    end

    # Authenticate the signed in user as the invited user
    def check_current_user_is_invited_user
	    invited_user = @collaboration_invitation.invited_user
	    unless current_user == invited_user
	      flash[:alert] = 'This invitation is not for you!'
	      redirect_to :back
	    end
	  end

    # Make sure a user does not invite himself to a project
    def check_current_user_not_invited_user
	    if current_user == @invited_user
	      flash[:alert] = "You can't invite yourself!"
	      redirect_to :back
	    end
	  end
	    	
    # Never trust parameters from the scary internet, only allow the white list through.
    #def collaboration_invitation_params
    #  params.require(:collaboration_invitation).permit(:project_id, :message, :invited_user_id, :invited_by_user_id, :status)
    #end

    # Only allow active applications to be accepted or denied.
    def check_invitation_active
	    unless @collaboration_invitation.active == 'yes'
		    flash[:alert] = 'This invitation is not active.'
		    redirect_to :back
		  end
	  end
	
    # Only allow pending applications to be accepted or denied.
    def check_invitation_pending
	    unless @collaboration_invitation.status == 'pending'
		    flash[:alert] = "This invitation has already been #{@collaboration_invitation.status}"
		    redirect_to :back
		  end
	  end
end
