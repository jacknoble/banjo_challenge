class PhotosController < ApplicationController
  def index
  	@photos = Photo.find_by_coords(params[:photo])
  end
end
