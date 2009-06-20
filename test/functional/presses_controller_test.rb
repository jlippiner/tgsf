require 'test_helper'

class PressesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:presses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create press" do
    assert_difference('Press.count') do
      post :create, :press => { }
    end

    assert_redirected_to press_path(assigns(:press))
  end

  test "should show press" do
    get :show, :id => presses(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => presses(:one).to_param
    assert_response :success
  end

  test "should update press" do
    put :update, :id => presses(:one).to_param, :press => { }
    assert_redirected_to press_path(assigns(:press))
  end

  test "should destroy press" do
    assert_difference('Press.count', -1) do
      delete :destroy, :id => presses(:one).to_param
    end

    assert_redirected_to presses_path
  end
end
