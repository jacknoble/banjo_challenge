require 'spec_helper'

describe Photo do
  it "pulls photos by location id" do
  	expect(Photo.find_by_location_id(3182106)[0].location_id).to eq(3182106)
  end
end
