require 'addressable/uri'
require 'rest-client'
class Photo < ActiveRecord::Base
  attr_accessible :image, :location_name, :location_id


  def self.find_by_coords(photo_params)
  	lat, lng = self.parse_coords(photo_params[:location])
  	uri = self.create_search_uri(lat,lng,photo_params[:radius])
  	response = JSON.parse(RestClient.get(uri))
  	location_ids = response['data'].map {|loc| loc['id']}
  	photos = []
  	location_ids[0..4].each do |id|
  		photos.concat(Photo.find_by_location_id(id))
  	end
  	photos
  end

  def self.find_by_location_id(id)
  	uri = self.location_id_uri(id)
  	response = JSON.parse(RestClient.get(uri))
  	photos = []
  	response['data'].each do |photo|
  		image = photo['images']['standard_resolution']
  		location_name = photo['location']['name']
  	 	photo =  Photo.new(:image => image, :location_name => location_name, :location_id => id)
  	 	photos << photo unless photo.nil?
  	end
  	photos.reject! {|p| p.nil?}
  	photos
  end

  private
  	def self.parse_coords(location)
  		coords = location.split(',')
  	end

  	def self.location_id_uri(id)
  		Addressable::URI.new(
  			:scheme => "https",
  			:host=> "api.instagram.com",
  			:path=> "v1/locations/#{id}/media/recent",
  			:query_values => {
  				:client_id => ENV["INSTAGRAM_ID"]
  		}).to_s
  	end

  	def self.create_search_uri(lat, lng, radius)
  		Addressable::URI.new(
			  :scheme => "https",
			  :host => "api.instagram.com",
			  :path => "v1/locations/search",
			  :query_values => {
			  	:client_id => ENV["INSTAGRAM_ID"], 
			  	:lat => lat,
			  	:lng => lng,
			  	:distact => radius.to_i
		  }).to_s
  	end

end
