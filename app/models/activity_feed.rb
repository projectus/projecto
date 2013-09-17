class ActivityFeed < ActiveRecord::Base
	# Subscribable is any model which has an activity feed (ie. projects, users...)	
  belongs_to :subscribable, polymorphic: true

  # If a feed is destroyed (through the destruction of subscribable), then destroy
  # all subscriptions to it and all activities in the feed.
  has_many :subscriptions, dependent: :destroy
  has_many :activities, dependent: :destroy

  # A feed must have a subscribable model associated with it (i.e. project, user...)
  validates_presence_of :subscribable

  # Gives a name to the activity feed based on what model it is associated with
  def name
	  return subscribable.name if subscribable.class == Project
	  return subscribable.username if subscribable.class == User
	  return nil
	end 	
end
