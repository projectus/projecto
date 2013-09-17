module SubscriptionHelper
  def link_to_subscribeable_profile(subscription)
	  link_to subscription.activity_feed.name, subscription.activity_feed.subscribable.profile
	end
end
