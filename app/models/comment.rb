class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, presence: true
  validates :project, presence: true
end
