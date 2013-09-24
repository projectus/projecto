class GalleryFolder < ActiveRecord::Base
  belongs_to :gallery

  has_many :images, class_name: 'GalleryImage', dependent: :destroy

  validates :gallery, presence: true
  validates_uniqueness_of :name, :scope => [:gallery_id]
end
