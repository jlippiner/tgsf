require 'test_helper'

class UnitesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unite" do
    assert_difference('Unite.count') do
      post :create, :unite => { }
    end

    assert_redirected_to unite_path(assigns(:unite))
  end

  test "should show unite" do
    get :show, :id => unites(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => unites(:one).to_param
    assert_response :success
  end

  test "should update unite" do
    put :update, :id => unites(:one).to_param, :unite => { }
    assert_redirected_to unite_path(assigns(:unite))
  end

  test "should destroy unite" do
    assert_difference('Unite.count', -1) do
      delete :destroy, :id => unites(:one).to_param
    end

    assert_redirected_to unites_path
  end
end
