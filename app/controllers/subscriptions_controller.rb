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
	  if params[:model] == 'project'
		  project = Project.find(params[:id])
		  if user_already_subscribed_to?(project)
			  redirect_to :back, alert: 'You are already subscribed to this!'
			  return
			end
	    current_user.subscribe(project)
		  respond_to do |format|
	      format.html { redirect_to :back, notice: "Subscribed to #{project.name}!" }
	    end
	  end
  end

  private
    def user_already_subscribed_to?(mod)
	    return current_user.subscriptions.exists?(subscribable: mod)
	  end
end
