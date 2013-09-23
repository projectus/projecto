class GalleryImage < ActiveRecord::Base
  belongs_to :gallery_folder

  has_attached_file :image, styles: {medium: "300x300>", thumb: ""}, :default_url => "/images/:style/missing.png"
end
