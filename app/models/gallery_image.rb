class GalleryImage < ActiveRecord::Base
  belongs_to :gallery_folder

  has_attached_file :image, :styles => lambda { |a| 
	q={:gallery => "660x380#"};
	if a.instance.user_avatar?
	  q.update({:thumb => "30x30#",:default => "180x180#"});
	elsif a.instance.project_avatar?
		q.update({:thumb => "30x30#",:default => "180x180#"});
	end
	return q }

  validates :gallery_folder, presence: true

	def reset!
		image.reprocess!(:thumb,:default)
	end
	
  def user_avatar?
	  Avatar.exists?(gallery_image: self, avatarable_type: 'UserProfile')
	end
	
	def project_avatar?
	  Avatar.exists?(gallery_image: self, avatarable_type: 'ProjectProfile')
	end
end
