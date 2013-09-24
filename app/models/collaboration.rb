class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  ROLES = [ROLE_PEASANT = 'peasant', ROLE_ADMIN = 'admin']

  # Make sure that a user cannot be associated with the project in more than one way.
  validates_uniqueness_of :user_id, :scope => :project_id

  validates :role, inclusion: {in: ROLES}

  after_create :add_creation_activity_to_activity_feed, :subscribe_user_to_project
  before_destroy :add_destruction_activity_to_activity_feed

  def self.create_peasant(user, project)
	  Collaboration.create!(user: user, role: ROLE_PEASANT, project: project)
	end
	
	private
	  def setup_activity(activity)
	    activity.activity_feed = project.activity_feed
	    activity.save!
	    activity.activity_references.create!(referenceable: user, title: 'user')	    
	    activity.activity_references.create!(referenceable: project, title: 'project')
		end
		
	  def add_creation_activity_to_activity_feed
	    activity = Activity.new(species:'new collaboration')
      setup_activity(activity)
		end
		
		def add_destruction_activity_to_activity_feed
	    activity = Activity.new(species:'collaboration ended')
      setup_activity(activity)
	  end
		
	  def subscribe_user_to_project
		  subscription = user.subscribe_to(project.activity_feed)
		  subscription.save!
		  #project.activity_feed.subscriptions.build(user: user)
		end
end
