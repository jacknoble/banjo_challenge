class PhotosController < ApplicationController
  def index
  	@location = params[:photo][:location]
  	@radius = params[:photo][:radius]
  	p params
  	p @radius
  	@photos = Photo.find_by_coords(params[:photo])
  end
end
