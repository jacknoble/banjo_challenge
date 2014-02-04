class PhotoSet < ActiveRecord::Base
  attr_accessible :radius, :lat, :lng, :location

  validates :radius, :lat, :lng, :presence => true

  has_many(
  	:photos,
  	:class_name => "Photo",
  	:primary_key => :id,
  	:foreign_key => :set_id
  	)


  def location= (loc)
  	self.lat, self.lng = PhotoSet.parse_coords(loc)
  	@location = loc
  end

	def self.parse_coords(location)
    location.gsub!(/\//, '')
    location.gsub!(/\s/, '')
		coords = location.split(',')
	end
end
