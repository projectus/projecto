module UserProfilesHelper
  def profile_tab_class(tab)
	  'active' if params[:controller] == tab
	end

  def gallery_image_url(gallery_image)
	  gallery_image.image.url(:gallery)
	end
	
	def gallery_image_tag(gallery_image,options={})
	  image_tag gallery_image_url(gallery_image), options
	end
end
