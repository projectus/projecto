class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  ROLES = [ROLE_PEASANT = 'peasant', ROLE_ADMIN = 'admin']

  # Make sure that a user cannot be associated with the project in more than one way.
  validates_uniqueness_of :user_id, :scope => :project_id

  validates :role, inclusion: {in: ROLES}

  def self.create_peasant(user, project)
	  Collaboration.create!(user: user, role: ROLE_PEASANT, project: project)
	end
	
end
