require 'spec_helper'

describe PhotoSet do
	it { should have_many(:photos) }

  context "with invalid search" do
  	let(:invalid_search) {set = PhotoSet.new}

  	it "validates presence of latitude" do
      expect(invalid_search).to have_at_least(1).error_on(:lat)
    end

    it "validates presence of longitude" do
      expect(invalid_search).to have_at_least(1).error_on(:lng)
    end

    it "validates presence of search radius" do
      expect(invalid_search).to have_at_least(1).error_on(:radius)
    end
  end
end
