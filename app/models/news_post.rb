class NewsPost < ActiveRecord::Base
  default_scope order('created_at DESC')

  belongs_to :project
  belongs_to :user

  validates :user, presence: true
  validates :project, presence: true
end
