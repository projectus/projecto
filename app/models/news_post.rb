class NewsPost < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :user, presence: true
  validates :project, presence: true
end
