class PhotoSet < ActiveRecord::Base
  attr_accessible :radius, :lat, :lng, :location

  validates :radius, :lat, :lng, :map, :presence => true

  before_validation :create_google_map

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
		coords = location.split(', ')
	end

  def create_google_map
    self.map = Addressable::URI.new(
      :scheme => "http",
      :host => "maps.googleapis.com",
      :path => "maps/api/staticmap",
      :query_values => {
        :center => "#{self.lat},#{self.lng}",
        :zoom => 11,
        :size => "600x180",
        :sensor => false
      }).to_s
  end
end
