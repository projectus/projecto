class Avatar < ActiveRecord::Base
  belongs_to :gallery_image
  belongs_to :avatarable, polymorphic: true

  validates :avatarable, presence: true
  validates_uniqueness_of :avatarable_id, :scope => [:avatarable_type]

  def image
	  gallery_image.image unless gallery_image.nil?
	end
	
	def update_image(gi)
	  old_gi = gallery_image
	  self.gallery_image = gi
	  save!
	  # Reset the old gallery image (remove the thumbnails)
	  old_gi.reset! unless old_gi.nil?
	  # Create the thumbnails for the new image
	  gi.reset!
	end
end
