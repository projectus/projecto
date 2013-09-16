class ActivityFeed < ActiveRecord::Base	
  belongs_to :subscribable, polymorphic: true

  has_many :subscriptions, dependent: :destroy
  has_many :activities, dependent: :destroy

  def name
	  subscribable.name if subscribable.class == Project
	end 	
end
