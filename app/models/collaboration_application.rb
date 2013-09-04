class CollaborationApplication < ActiveRecord::Base
  belongs_to :project
  belongs_to :user, foreign_key: :applicant_user_id

  # Make sure that a user cannot apply more than once to a project.
  #validates_uniqueness_of :applicant_user_id, :scope => :project_id

  def cash_in
	  if self.status == 'accepted'
		  accept
		elsif self.status == 'denied'
			deny
	  end
	end

  def deactivate
    self.active = 'no'
    save
	end
		
  private
    def accept
	    Collaboration.create!(user: self.user, role: 'peasant', project: self.project)
      #self.destroy
	  end

    def deny
	    #self.destroy
	  end
end
