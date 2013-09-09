class UserProfile < ActiveRecord::Base
  belongs_to :user

  # Make sure every user has a profile
  validates :user, presence: true
end
