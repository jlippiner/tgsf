require 'test_helper'

class DonationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:donations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create donation" do
    assert_difference('Donation.count') do
      post :create, :donation => { }
    end

    assert_redirected_to donation_path(assigns(:donation))
  end

  test "should show donation" do
    get :show, :id => donations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => donations(:one).to_param
    assert_response :success
  end

  test "should update donation" do
    put :update, :id => donations(:one).to_param, :donation => { }
    assert_redirected_to donation_path(assigns(:donation))
  end

  test "should destroy donation" do
    assert_difference('Donation.count', -1) do
      delete :destroy, :id => donations(:one).to_param
    end

    assert_redirected_to donations_path
  end
end
