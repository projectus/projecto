class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  ROLES = [ROLE_PEASANT = 'peasant', ROLE_ADMIN = 'admin']

  # Make sure that a user cannot be associated with the project in more than one way.
  validates_uniqueness_of :user_id, :scope => :project_id

  validates :role, inclusion: {in: ROLES}

  has_many :activities, as: :loggable

  after_create :add_creation_activity_to_activity_feed
  before_destroy :add_destruction_activity_to_activity_feed

  def self.create_peasant(user, project)
	  Collaboration.create!(user: user, role: ROLE_PEASANT, project: project)
	end
	
	private
	  def add_creation_activity_to_activity_feed
	    activity = activities.build(species:'new collaboration',headline:"#{user.username} joined #{project.name}!")
	    activity.activity_feed = project.activity_feed
	    activity.save!
		end
		
		def add_destruction_activity_to_activity_feed
	    activity = activities.build(species:'collaboration ended',headline:"#{user.username} left #{project.name}!")
	    activity.activity_feed = project.activity_feed
	    activity.save!
	  end
end
