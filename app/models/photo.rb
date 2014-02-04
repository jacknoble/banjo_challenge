require 'addressable/uri'
require 'rest-client'
class Photo < ActiveRecord::Base
  attr_accessible :image

  def self.find_by_coords(photo_params)
  	lat, lng = self.parse_coords(photo_params[:location])
  	uri = self.create_media_uri(lat,lng,photo_params[:radius])
  	response = JSON.parse(RestClient.get(uri))
  	photos = []

  	response['data'].each do |photo|
  		image = photo['images']['standard_resolution']
  	 	photo_object =  Photo.new(:image => image)
  	 	photos << photo_object
  	end

		photos
  end

  
  private
  	def self.parse_coords(location)
  		coords = location.split(', ')
  	end

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
