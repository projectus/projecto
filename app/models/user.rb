class User < ActiveRecord::Base
	
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validation ##################################

	validates :username, presence: true
  
  # After save ###################################
 
	after_save :create_empty_profile, on: :create
	
	# Associations #################################
			
  has_many :collaborations, dependent: :destroy
  has_many :projects, through: :collaborations
  has_many :owned_projects, class_name: 'Project', foreign_key: :owner_id, dependent: :destroy
	
  has_many :collaboration_applications, foreign_key: :applicant_user_id, dependent: :destroy
  has_many :received_collaboration_invitations, class_name: 'CollaborationInvitation', foreign_key: :invited_user_id, dependent: :destroy
  has_many :sent_collaboration_invitations, class_name: 'CollaborationInvitation', foreign_key: :invited_by_user_id, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :posted_tasks, class_name: 'Task', foreign_key: :poster_id

  has_one :user_profile, dependent: :destroy

  # Public methods ###################################

  def is_associated_with_project?(project)
	  a = collaborations.exists?(project: project)
	  b = self == project.owner
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
    # Create empty user_profile associated with self
    def create_empty_profile
      user_profile.create(card_xml: 'card', resume_xml: 'resume')
    end
end
