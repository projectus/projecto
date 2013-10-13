class Comment < ActiveRecord::Base
	default_scope order('created_at DESC')
  
  belongs_to :user
  belongs_to :project

  validates :user, presence: true
  validates :project, presence: true
end
