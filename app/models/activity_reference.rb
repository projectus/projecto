class ActivityReference < ActiveRecord::Base
	
  belongs_to :referenceable, polymorphic: true
  belongs_to :activity

  # VALIDATION #####################################################

  # Make sure a reference is only used once in an activity for each title
  #validates_uniqueness_of :activity_id, :scope => [:referenceable_id,:referenceable_type,:title]
 
  # Make sure the title of the reference is unique per activity
  validates_uniqueness_of :title, :scope => [:activity_id]

  validates :activity, presence: true
  validates :referenceable, presence: true

  # AFTER DESTROY ###################################################

  # Upon destroying the references in the activity, 
  # remove the activity if there are no references left
  after_destroy :remove_empty_activity

  private
    def remove_empty_activity
	    activity.destroy if activity.activity_references.empty?
	  end
end
