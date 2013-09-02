class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :project

  # Make sure a tag is only used once on a project
  validates_uniqueness_of :tag_id, :scope => :project_id

end
