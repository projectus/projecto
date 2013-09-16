class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity_feed

  # Make sure a user only subscribes once to a feed
	validates :user_id, :uniqueness => { :scope => :activity_feed_id }

  def activities
	  activity_feed.activities
	end
end
