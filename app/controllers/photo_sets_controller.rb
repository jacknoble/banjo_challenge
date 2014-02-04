class PhotoSetsController < ApplicationController
	def create
		@photo_set = PhotoSet.new(params[:set])
		if @photo_set.save
			Photo.pull_for_set(@photo_set)
			redirect_to photo_set_photos_url(@photo_set)
		else
			flash[:errors] = @photo_set.errors.full_messages
			redirect_to :back
		end
	end

end
