require 'addressable/uri'
require 'rest-client'
class Photo < ActiveRecord::Base
  attr_accessible :image


  def self.find_by_coords(photo_params)
  	lat, lng = self.parse_coords(photo_params[:location])
  	uri = self.create_search_uri(lat,lng,photo_params[:radius])
  	response = JSON.parse(RestClient.get(uri))
  	Photo.find_by_location_id(response["data"][0]["id"])
  end

  def self.find_by_location_id(id)
  	uri = self.location_id_uri(id)
  	response = RestClient.get(uri)
  	photos = []
  	response.each do |photo|
  		image = photo['images']['standard_resolution']
  	 	photos << Photo.new(:image => image)
  	end

  	photos
  end

  private
  	def self.parse_coords(location)
  		coords = location.split('/')
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
		  }).to_s
  	end

end
