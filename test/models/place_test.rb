require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  test "Place saves with all parameters" do
    place = FactoryGirl.create(:place)
    assert place.valid?
  end

  test "Place does not save without all parameters" do
    place = FactoryGirl.build(:place, name: "")
    assert_not place.valid?
  end
end
