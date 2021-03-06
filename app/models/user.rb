class User < ActiveRecord::Base
	
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validation ##################################

	validates :username, presence: true
  
  # Before create ###################################
 
	before_create :make_empty_profile, :make_gallery
	
	# Associations #################################

  has_one  :gallery, as: :showcasable, dependent: :destroy
  has_one  :activity_feed, dependent: :destroy
				
  has_many :collaborations, dependent: :destroy
  has_many :projects, through: :collaborations
  has_many :owned_projects, class_name: 'Project', foreign_key: :owner_id, dependent: :destroy
	
  has_many :collaboration_applications, foreign_key: :applicant_user_id, dependent: :destroy
  has_many :received_collaboration_invitations, class_name: 'CollaborationInvitation', foreign_key: :invited_user_id, dependent: :destroy
  has_many :sent_collaboration_invitations, class_name: 'CollaborationInvitation', foreign_key: :invited_by_user_id, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :news, class_name: 'NewsPost', dependent: :destroy
  has_many :posted_tasks, class_name: 'Task', foreign_key: :poster_id

  has_one :profile, class_name: 'UserProfile', dependent: :destroy

  has_many :subscriptions, dependent: :destroy
  has_many :subscribed_feeds, through: :subscriptions, source: :activity_feed
  has_many :subscribed_activities, through: :subscribed_feeds, source: :activities

  # Public methods ###################################
	
  def subscribe_to(feed)
	  subscriptions.build(activity_feed: feed)
		#subscription.save!
	end
	
	def subscribed_to?(feed)
	  subscriptions.exists?(activity_feed: feed)
	end
	
	def is_owner_of_project?(project)
	  self == project.owner
	end

  def has_any_projects?
	  !owned_projects.empty?
	end
		
	def is_collaborating_on_project?(project)
	  collaborations.exists?(project: project)
	end

  def is_associated_with_project?(project)
	  a = is_owner_of_project?(project)
	  b = is_collaborating_on_project?(project)
	  return a || b
	end
		
	def has_pending_application_to_project?(project)
		collaboration_applications.exists?(project: project, status: 'pending')
	end

	def has_pending_invitation_to_project?(project)
	  received_collaboration_invitations.exists?(project: project, status: 'pending')
  end

  # Private methods ###################################

  private
    # Create empty user profile associated with self
    def make_empty_profile
      profile = build_profile
      profile.generate_empty_resume
      profile.generate_empty_card(email: email)
      profile.generate_empty_avatar
    end

    def make_gallery
      build_gallery
    end
end
