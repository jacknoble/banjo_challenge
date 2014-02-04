class PhotosController < ApplicationController
  def index
  	@set = PhotoSet.find(params[:photo_set_id])
  	@photos = @set.photos.page params[:page]
  	@map = Addressable::URI.new(
 	    :scheme => "http",
      :host => "maps.googleapis.com",
      :path => "maps/api/js",
      :query_values => {
        :key => ENV["GOOGLE_MAPS_KEY"],
        :sensor => false 
      }).to_s
  	render :index
  end
end
