class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user_id, presence:true
end
