class CollaborationApplication < ActiveRecord::Base
  belongs_to :project
  belongs_to :applicant, class_name: 'User', foreign_key: :applicant_user_id

  validates :applicant, presence: true
  validates :project, presence: true

  validate :applicant_is_not_associated_with_project
  validate :applicant_does_not_have_pending_application_to_project
  validate :applicant_does_not_have_pending_invitation_to_project

  # Make sure that a user cannot apply more than once to a project.
  #validates_uniqueness_of :applicant_user_id, :scope => :project_id

  def cash_in
	  if self.status == 'accepted'
		  accept
		elsif self.status == 'declined'
			deny
	  end
	end
		
  private
    def accept
	    Collaboration.create!(user: self.user, role: 'peasant', project: self.project)
      #self.destroy
	  end

    def deny
	    #self.destroy
	  end
	
	  def applicant_is_not_associated_with_project
		  if applicant.is_associated_with_project?(project)
			  errors[:base] << "You are already associated with this project."
			end
		end
		
		def applicant_does_not_have_pending_application_to_project
		  if applicant.has_pending_application_to_project?(project)
				errors[:base] << "You have a pending application to this project."
			end
		end
		
		def applicant_does_not_have_pending_invitation_to_project
		  if applicant.has_pending_invitation_to_project?(project)
				errors[:base] << "You have a pending invitation to this project."
			end
		end
end
