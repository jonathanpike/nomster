require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "Comment create" do
    user = FactoryGirl.create(:user)
    sign_in user    

    place = FactoryGirl.create(:place)

    assert_difference 'place.comments.count' do
      post :create, :place_id => place.id, :comment => {
        :rating => '5_stars',
        :message => 'Really great pizza!'
        }    
    end

    assert_redirected_to place_path(place)
    comment = Comment.last
    assert_equal user, comment.user
  end
  
  test "Comment create without login" do
    place = FactoryGirl.create(:place)
    
    assert_no_difference 'place.comments.count' do
      post :create, :place_id => place.id, :comment => {
        :rating => '5_stars',
        :message => 'Really great pizza!'
        }    
    end
    
    assert_redirected_to new_user_session_path
  end
  
  test "Comment update" do
    place = FactoryGirl.create(:place)
    comment = FactoryGirl.create(:comment)
    sign_in comment.user

    patch :update, place_id: place.id, id: comment.id, :comment => {:message => "Fantastic!", :rating => "5_stars"}
    assert_redirected_to place_path(place)
  end
  
  test "Comment update without login" do
    place = FactoryGirl.create(:place)
    comment = FactoryGirl.create(:comment)
    
    patch :update, place_id: place.id, id: comment.id, :comment => {:message => "Fantastic!", :rating => "5_stars"}
    assert_redirected_to new_user_session_path
  end
  
  test "Comment update on another users comment" do
    place = FactoryGirl.create(:place)
    comment = FactoryGirl.create(:comment)
    user = FactoryGirl.create(:user)
    sign_in user

    patch :update, place_id: place.id, id: comment.id,  :comment => {:message => "Fantastic!", :rating => "5_stars"}
    assert_response :forbidden
  end
  
  test "Comment destroy" do
    place = FactoryGirl.create(:place)
    comment = FactoryGirl.create(:comment, :place => place)
    sign_in comment.user

    assert_difference('place.comments.count', -1) do
      delete :destroy, place_id: place.id, id: comment.id 
    end

    assert_redirected_to place_path(place)
  end
  
  test "Comment destroy without login" do
    place = FactoryGirl.create(:place)
    comment = FactoryGirl.create(:comment)

    delete :destroy, place_id: place.id, id: comment.id 
    assert_redirected_to new_user_session_path
  end
  
  test "Comment destroy on another users comment" do 
    place = FactoryGirl.create(:place)
    user = FactoryGirl.create(:user)
    sign_in user
    
    comment = FactoryGirl.create(:comment)

     assert_no_difference('place.comments.count') do
        delete :destroy, place_id: place.id, id: comment.id 
    end
    
    assert_response :forbidden
  end
end
