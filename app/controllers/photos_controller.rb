class PhotosController < ApplicationController
  def index
  	@set = PhotoSet.find(params[:photo_set_id])
  	@photos = @set.photos.page params[:page]
  	render :index
  end
end
