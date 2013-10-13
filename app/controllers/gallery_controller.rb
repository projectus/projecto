class GalleryController < ApplicationController
	def show
		@gallery = Gallery.find(params[:id])
	  @images = @gallery.images
	end
	
  def upload
	  unless params[:image].nil?
		  gallery = Gallery.find(params[:id])
	    @uploaded_image = gallery.root.images.build(params.permit(:image))
    end
    respond_to do |format|
	    if @uploaded_image.save
	      format.js
      else
	      format.html
	    end
	  end
  end

  private
    def associated_project
	    @gallery.showcasable
	  end
end
