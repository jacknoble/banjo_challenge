require 'addressable/uri'
require 'rest-client'
class Photo < ActiveRecord::Base
  attr_accessible :location, :radius


  def self.search_by_location(photo_params)
  	lat, lng = self.parse_coords(photo_params[:location])
  	url = self.create_search_url(lat,lng,photo_params[:radius])
  	p url
  	response = RestClient.get(url)
  	p response
  end

  private
  	def self.parse_coords(location)
  		coords = location.split('/')
  	end

  	def self.create_search_url(lat, lng, radius)
  		url = Addressable::URI.new(
			  :scheme => "http",
			  :host => "api.instagram.com",
			  :path => "v1/locations/search",
			  :query_values => {:client_id => ENV["INSTAGRAM_ID"], :lat => lat, :lng => lng, :distance => radius}
				).to_s
  	end

end
