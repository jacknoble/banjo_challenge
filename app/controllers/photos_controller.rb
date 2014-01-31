class PhotosController < ApplicationController
  def index
  	@photos = Photos.find_by_location
  	render :index
  end
end
