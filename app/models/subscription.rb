class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscribable, polymorphic: true

	validates :user_id, :uniqueness => { :scope => [:subscribable_type, :subscribable_id] }

  # TODO Validate that subscribable has an activity_feed

  def activities
	  subscribable.activity_feed.activities
	end
end
