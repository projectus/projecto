class UserAvatar < ActiveRecord::Base
  belongs_to :gallery_image
  belongs_to :user_profile
end
