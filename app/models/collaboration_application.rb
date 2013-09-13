class CollaborationApplication < ActiveRecord::Base
  belongs_to :project
  belongs_to :applicant, class_name: 'User', foreign_key: :applicant_user_id

  STATUSES = [STATUS_ACCEPTED = 'accepted', STATUS_DECLINED = 'declined', STATUS_PENDING = 'pending']

  validates :applicant, presence: true
  validates :project, presence: true
  validates :status, inclusion: {in: STATUSES}

  validate :applicant_does_not_own_project, on: :create
  validate :applicant_is_not_collaborating_on_project, on: :create
  validate :applicant_does_not_have_pending_application_to_project, on: :create
  validate :applicant_does_not_have_pending_invitation_to_project, on: :create

  validate :only_update_status_from_pending, on: :update
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
	    Collaboration.create_peasant(self.applicant, self.project)
      #self.destroy
	  end

    def decline
	    #self.destroy
	  end

	  # Check that the applicant is not already collaborating on this project.	
	  def applicant_is_not_collaborating_on_project
		  if applicant.is_collaborating_on_project?(project)
			  errors[:base] << "You are already collaborating on this project."
			end
		end
		
		# Check that the applicant is not the owner of this project.	
	  def applicant_does_not_own_project
		  if applicant.is_owner_of_project?(project)
			  errors[:base] << "You can't apply to your own project!"
			end
		end
		
	  # Check that the applicant does not already have a pending application.				
		def applicant_does_not_have_pending_application_to_project
		  if applicant.has_pending_application_to_project?(project)
				errors[:base] << "You may only have a single pending application to this project."
			end
		end

	  # Check that the applicant does not already have a pending invitation.		
		def applicant_does_not_have_pending_invitation_to_project
		  if applicant.has_pending_invitation_to_project?(project)
				errors[:base] << "You have a pending invitation to this project."
			end
		end
		
		# Only allow pending applications to be accepted or denied.
    def only_update_status_from_pending
	    if changed.length > 1
		    errors[:base] << 'You cannot modify this application.'
		    return
		  end
			old_status = changed_attributes['status']
			if old_status != 'pending'
			  errors[:base] << "This application is already #{old_status||=status}."
			end
	  end
end
