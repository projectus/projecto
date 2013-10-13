class GalleryController < ApplicationController
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
end
