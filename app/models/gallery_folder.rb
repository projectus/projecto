class GalleryFolder < ActiveRecord::Base
  belongs_to :gallery

  has_many :images, class_name: 'GalleryImage'
end
