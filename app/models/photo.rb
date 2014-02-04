require 'addressable/uri'
require 'rest-client'
class Photo < ActiveRecord::Base
  attr_accessible :image, :set_id

  belongs_to(
  	:set,
  	:class_name => "PhotoSet",
  	:foreign_key => :set_id,
  	:primary_key => :id
  	)

  paginates_per 6

  def self.pull_for_set(set)
  	uri = self.create_media_uri(set.lat, set.lng, set.radius)
  	response = JSON.parse(RestClient.get(uri))
    p response
  	photos = []
  	response['data'].each do |photo|
  		image = photo['images']['standard_resolution']['url']
  	 	photo_object =  Photo.create(:image => image, :set_id => set.id)
  	 	photos << photo_object
  	end

		photos
  end

  
  private

  	def self.create_media_uri(lat, lng, radius)
  		Addressable::URI.new(
			  :scheme => "https",
			  :host => "api.instagram.com",
			  :path => "v1/media/search",
			  :query_values => {
			  	:client_id => ENV["INSTAGRAM_ID"], 
			  	:lat => lat,
			  	:lng => lng,
			  	:distact => radius.to_i
		  }).to_s
  	end

end
