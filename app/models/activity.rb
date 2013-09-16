class Activity < ActiveRecord::Base
  default_scope order('created_at DESC')

  belongs_to :activity_feed
  belongs_to :loggable, polymorphic: true
end
