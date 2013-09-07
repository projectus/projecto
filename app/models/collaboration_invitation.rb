class CollaborationInvitation < ActiveRecord::Base
  belongs_to :project
  belongs_to :invited_user, :class_name => 'User', foreign_key: :invited_user_id
  belongs_to :invited_by_user, :class_name => 'User', foreign_key: :invited_by_user_id

  # Make sure that a user cannot be invited more than once to a project.
  #validates_uniqueness_of :invited_user_id, :scope => :project_id

  validates :invited_user, presence: true
  validates :invited_by_user, presence: true

  def cash_in
	  if self.status == 'accepted'
		  accept
		elsif self.status == 'denied'
			deny
	  end
	end
		
  private
  def accept
	  Collaboration.create!(user: self.invited_user, role: 'peasant', project: self.project)
    #self.destroy
	end

  def deny
	  #self.destroy
	end
end
