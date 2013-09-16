class ActivityFeed < ActiveRecord::Base	
  belongs_to :feedable, polymorphic: true

  has_many :activities, dependent: :destroy  	
end
