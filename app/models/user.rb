class User < ActiveRecord::Base
	
  validates :username, presence: true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collaborations, dependent: :destroy
  has_many :projects, through: :collaborations
	
  has_many :collaboration_applications, foreign_key: :applicant_user_id, dependent: :destroy
  has_many :collaboration_invitations, foreign_key: :invited_user_id, dependent: :destroy

  has_many :comments, dependent: :destroy

  def owned_projects
	  collaborations.find_all_by_role('owner').collect {|c| c.project}
	end

  def is_collaborating_on_project?(project)
	  !collaborations.find_by_project_id(project).nil?
	end
	
	def has_pending_application_to_project?(project)
		!collaboration_applications.find_by_project_id_and_status(project,'pending').nil?
	end

	def has_pending_invitation_to_project?(project)
	  !collaboration_invitations.find_by_project_id_and_status(project,'pending').nil?
	end
end
