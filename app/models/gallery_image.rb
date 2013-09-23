class GalleryImage < ActiveRecord::Base
  belongs_to :gallery_folder

  has_attached_file :image, :styles => lambda { |a| 
	q={:gallery => "180x180#"};
	q.update({:thumb => "30x30#",:default => "180x180#"}) if a.instance.user_avatar?;
	return q }

  def user_avatar?
	  UserAvatar.exists?(gallery_image: self)
	end
end
