require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  test "create new photo" do
    place = FactoryGirl.create(:place)
    user = FactoryGirl.create(:user)
    sign_in user
    
    assert_difference("place.photos.count") do 
      post :create, :place_id => place.id, :photo => { :caption => "Awesome stuff", :picture => "stuff.jpg" }
    end
    
    assert_redirected_to place_path(place)
  end
end
