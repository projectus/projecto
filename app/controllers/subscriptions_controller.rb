class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
	  @user = User.find(params[:user_id])
	  @subscriptions = @user.subscriptions
  end

  def destroy
	  @subscription = Subscription.find(params[:id])
	  user = @subscription.user
	
	  unless current_user == user
      redirect_to :back, alert: 'This is not your subscription!'
      return
    end

	  feed = @subscription.activity_feed
	  @subscription.destroy
		respond_to do |format|
	    format.html { redirect_to user_subscriptions_path(user), notice: "Unsubscribed from #{feed.name}!" }
	  end
  end

  def create
	  feed = ActivityFeed.find(params[:feed_id])
		if current_user.subscribed_to?(feed)
			redirect_to feed.subscribable, alert: 'You are already subscribed to this!'
			return
	  end
	  @subscription = current_user.subscribe_to(feed)
		respond_to do |format|
			if @subscription.save
	      format.html { redirect_to feed.subscribable, notice: "Subscribed to #{feed.name}!" }
	    else
	      format.html { render partial: 'errors' }		  
		  end
	  end
  end

  private
    def associated_user
	    @user ||= @subscription.user
	  end
end