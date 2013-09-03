class CollaborationApplication < ActiveRecord::Base
  belongs_to :project
  belongs_to :user, foreign_key: :applicant_user_id

  # Make sure that a user cannot apply more than once to a project.
  validates_uniqueness_of :applicant_user_id, :scope => :project_id

end
