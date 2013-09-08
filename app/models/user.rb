class User < ActiveRecord::Base
	
  validates :username, presence: true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collaborations, dependent: :destroy
  has_many :projects, through: :collaborations
  has_many :owned_projects, class_name: 'Project', foreign_key: :owner_id, dependent: :destroy
	
  has_many :collaboration_applications, foreign_key: :applicant_user_id, dependent: :destroy
  has_many :collaboration_invitations, foreign_key: :invited_user_id, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :posted_tasks, class_name: 'Task', foreign_key: :poster_id

  def is_associated_with_project?(project)
	  a = !collaborations.find_by_project_id(project).nil?
	  b = self == project.owner
	  return a || b
	end
	
	def has_pending_application_to_project?(project)
		!collaboration_applications.find_by_project_id_and_status(project,'pending').nil?
	end

	def has_pending_invitation_to_project?(project)
	  !collaboration_invitations.find_by_project_id_and_status(project,'pending').nil?
	end
end
