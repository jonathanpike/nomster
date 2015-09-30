require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    user = FactoryGirl.create(:user)
   sign_in user    

    get :new
    assert_response :success
  end

  test "should create place" do
    user = FactoryGirl.create(:user)
    sign_in user    

    assert_difference('Place.count') do
      post :create, :place => { :name => "Bob's Pizza", :address => "2233 Delkus Crescent, Mississauga, Ontario L5A 1K8",
    :description => "Awesome pizza!"}
    end

    assert_redirected_to root_path
  end

  test "should not save invalid place" do
    user = FactoryGirl.create(:user)
    sign_in user   

    assert_no_difference 'Place.count' do
      post :create, :place => { :name => ""}
    end

    assert_response :unprocessable_entity
  end

  test "should show place" do
    place = FactoryGirl.create(:place)

    get :show, id: place
    assert_response :success
  end

  test "should get edit" do
    place = FactoryGirl.create(:place)
    sign_in place.user

    get :edit, id: place.id
    assert_response :success
  end

  test "edit without login" do
    place = FactoryGirl.create(:place)

    get :edit, id: place.id
    assert_redirected_to new_user_session_path
  end

  test "edit another users place" do
    place = FactoryGirl.create(:place)
    user = FactoryGirl.create(:user)
    sign_in user

    get :edit, id: place.id
    assert_response :forbidden
  end

  test "should update place" do
    place = FactoryGirl.create(:place)
    sign_in place.user

    patch :update, id: place.id, :place => {:name => "Jill's Pizza Place"}
    assert_redirected_to root_path
  end

  test "update without login" do
    place = FactoryGirl.create(:place)
    patch :update, id: place.id, :place => {:name => "Jill's Pizza Place"}
    assert_redirected_to new_user_session_path
  end

  test "update other users place" do
    place = FactoryGirl.create(:place)
    user = FactoryGirl.create(:user)
    sign_in user

    patch :update, id: place.id, :place => {:name => "Jill's Pizza Place"}
    assert_response :forbidden
  end

  test "should destroy place" do
    place = FactoryGirl.create(:place)
    sign_in place.user

    assert_difference('Place.count', -1) do
        delete :destroy, id: place.id
    end

    assert_redirected_to root_path
  end

  test "destroy without login" do
    place = FactoryGirl.create(:place)
    delete :destroy, id: place.id
    
    assert_redirected_to new_user_session_path
  end

  test "destroy another users place" do
    place = FactoryGirl.create(:place)
    user = FactoryGirl.create(:user)
    sign_in user

    delete :destroy, id: place.id
    assert_response :forbidden
  end
end
