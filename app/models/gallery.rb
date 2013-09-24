class Gallery < ActiveRecord::Base
	belongs_to :showcasable, polymorphic: true
	
	has_many :folders, class_name: 'GalleryFolder', dependent: :destroy
	
	# Make sure every showcasable model has only one gallery
  validates :showcasable, presence: true
  validates_uniqueness_of :showcasable_id, :scope => [:showcasable_type]

  before_create :make_root_folder

  def root
	  folders.where(name: 'root').first
	end
	
  private
    def make_root_folder
	    folders.build(name: 'root')
	  end
end
