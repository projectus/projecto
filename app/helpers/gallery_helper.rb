module GalleryHelper
	def gallery_image_url(gallery_image)
		return nil if gallery_image.image.nil?
	  gallery_image.image.url(:default)
	end
	
	def gallery_image_tag(gallery_image,options={})
		return image_tag(nil,options) if gallery_image.image.nil?
	  image_tag gallery_image_url(gallery_image), options
	end
end
