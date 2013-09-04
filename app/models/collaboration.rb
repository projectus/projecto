class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  # Make sure that a user cannot be associated with the project in more than one way.
  #validates_uniqueness_of :user_id, :scope => :project_id
	
  def destroy
	  # Deactivate the active application which is associated
	  application = self.user.collaboration_applications.find_by_project_id_and_active(self.project,'yes')
	  unless application.nil?
		  application.deactivate
		end
		# Deactivate the active invitation which is associated
	  invitation = self.user.collaboration_invitations.find_by_project_id_and_active(self.project,'yes')
	  unless invitation.nil?
		  invitation.deactivate
		end
		super
	end
end
