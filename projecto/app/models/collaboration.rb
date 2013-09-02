class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  # Make sure that a user cannot be associated with the project in more than one way.
  validates_uniqueness_of :user_id, :scope => :project_id

end
