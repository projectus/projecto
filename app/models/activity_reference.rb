class ActivityReference < ActiveRecord::Base
  belongs_to :referenceable, polymorphic: true
  belongs_to :activity

  # Make sure a reference is only used once in an activity
  validates_uniqueness_of :activity_id, :scope => [:referenceable_id,:referenceable_type]
 
  # Make sure the title of the reference is unique
  validates_uniqueness_of :title, :scope => [:activity_id]

  validates_presence_of :activity
  validates_presence_of :referenceable
end
