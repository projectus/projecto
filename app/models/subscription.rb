class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity_feed

  # Make sure a user only subscribes once to a feed
	validates :user_id, :uniqueness => { :scope => :activity_feed_id }

  # Return the activities listed in the feed this subscriptions refers to
  def activities
	  activity_feed.activities
	end
end
