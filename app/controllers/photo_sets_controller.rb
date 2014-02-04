class PhotoSetsController < ApplicationController
	def create
		@photo_set = PhotoSet.new(params[:set])
		if @photo_set.save
			begin
  			Photo.pull_for_set(@photo_set)
			rescue => e
				errors =  JSON.parse(e.response)
  			flash[:errors] = errors['meta']['error_message'].capitalize
  			redirect_to :back
  		else
  			redirect_to photo_set_photos_url(@photo_set)
			end
		else
			flash[:errors] = "Enter latitude then longitude separated by a comma."
			redirect_to :back
		end
	end

end
