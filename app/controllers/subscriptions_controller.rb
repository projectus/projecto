class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
	  @user = User.find(params[:user_id])
	  @subscriptions = @user.subscriptions
  end

  def destroy
	  @subscription = Subscription.find(params[:id])
	  @subscription.destroy
  end

  def create
	  feed = ActivityFeed.find(params[:feed_id])
		if current_user.subscribed_to?(feed)
			redirect_to :back, alert: 'You are already subscribed to this!'
			return
	  end
	  current_user.subscribe(feed)
		respond_to do |format|
	    format.html { redirect_to :back, notice: "Subscribed to #{feed.name}!" }
	  end
  end
end
