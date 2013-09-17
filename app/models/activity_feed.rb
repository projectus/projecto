class ActivityFeed < ActiveRecord::Base	
  belongs_to :subscribable, polymorphic: true

  has_many :subscriptions, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates_presence_of :subscribable

  def name
	  return subscribable.name if subscribable.class == Project
	end 	
end
