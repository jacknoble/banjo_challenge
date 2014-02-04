require 'spec_helper'

describe Photo do

	it { should belong_to(:set) }

	context "with invalid data" do
  	let(:invalid_photo) {photo = Photo.new}

  	it "validates presence of set_id" do
      expect(invalid_photo).to have_at_least(1).error_on(:set_id)
    end

    it "validates presence of image" do
      expect(invalid_photo).to have_at_least(1).error_on(:image)
    end
  end

  it "pulls photos by set info" do
  	set = PhotoSet.new(:location => "40.7577, 73.9857", :radius => "5000")
  	set.save
  	Photo.pull_for_set(set)
  	set.photos.should have_at_least(5).items
  end
end
