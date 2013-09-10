class CollaborationInvitation < ActiveRecord::Base
  belongs_to :project
  belongs_to :invited_user, class_name: 'User', foreign_key: :invited_user_id
  belongs_to :invited_by_user, class_name: 'User', foreign_key: :invited_by_user_id

  STATUSES = [STATUS_ACCEPTED = 'accepted', STATUS_DECLINED = 'declined', STATUS_PENDING = 'pending']

  # Validation #######################################

  validates :invited_user, presence: true
  validates :invited_by_user, presence: true

  validates :status, inclusion: {in: STATUSES}

  validate :invited_user_is_not_invited_by_himself
  validate :invited_user_is_not_associated_with_project, on: :create
  validate :invited_user_does_not_have_pending_application_to_project, on: :create
  validate :invited_user_does_not_have_pending_invitation_to_project, on: :create

  validate :only_update_status_from_pending, on: :update

  ######################################################

  after_update :cash_in
				
  private
    def cash_in
	    if self.status == 'accepted'
		    accept
		  elsif self.status == 'declined'
			  decline
	    end
	  end
	
    def accept
	    Collaboration.create_peasant(self.invited_user, self.project)
	    #self.destroy
	  end

    def decline
	    #self.destroy
	  end

	  # Check that the invited user is not already collaborating on this project.	
	  def invited_user_is_not_associated_with_project
	    if invited_user.is_associated_with_project?(project)
		    errors[:base] << "#{invited_user.username} is already collaborating on this project."
		  end
		end

	  # Check that the invited user does not already have a pending application.
		def invited_user_does_not_have_pending_application_to_project
		  if invited_user.has_pending_application_to_project?(project)
				errors[:base] << "#{invited_user.username} has a pending application to this project."
			end
		end

	  # Check that the user does not already have a pending invitation.		
		def invited_user_does_not_have_pending_invitation_to_project
		  if invited_user.has_pending_invitation_to_project?(project)
				errors[:base] << "#{invited_user.username} has a pending invitation to this project."
			end
		end

    # Check that the invited user has not been invited by himself
	  def invited_user_is_not_invited_by_himself
	    errors[:base] << 'You cannot invite yourself!' if invited_user == invited_by_user
	  end
			
		# Only allow pending invitations to be accepted or denied.
    def only_update_status_from_pending
	    if changed.length > 1
		    errors[:base] << 'You cannot modify this invitation.'
		    return
		  end
			old_status = changed_attributes['status']
			if old_status != 'pending'
			  errors[:base] << "This invitation is already #{old_status||=status}."
			end
	  end
end
