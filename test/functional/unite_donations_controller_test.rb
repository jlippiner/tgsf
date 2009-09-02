require 'test_helper'

class UniteDonationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unite_donations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unite_donation" do
    assert_difference('UniteDonation.count') do
      post :create, :unite_donation => { }
    end

    assert_redirected_to unite_donation_path(assigns(:unite_donation))
  end

  test "should show unite_donation" do
    get :show, :id => unite_donations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => unite_donations(:one).to_param
    assert_response :success
  end

  test "should update unite_donation" do
    put :update, :id => unite_donations(:one).to_param, :unite_donation => { }
    assert_redirected_to unite_donation_path(assigns(:unite_donation))
  end

  test "should destroy unite_donation" do
    assert_difference('UniteDonation.count', -1) do
      delete :destroy, :id => unite_donations(:one).to_param
    end

    assert_redirected_to unite_donations_path
  end
end
