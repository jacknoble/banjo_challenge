class PhotosController < ApplicationController
  def index
  	@response = Photo.search_by_location(params[:photo])
  	render :json => @response
  end
end
