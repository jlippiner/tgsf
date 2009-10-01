require 'test_helper'

class InvolvementsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:involvements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create involvement" do
    assert_difference('Involvement.count') do
      post :create, :involvement => { }
    end

    assert_redirected_to involvement_path(assigns(:involvement))
  end

  test "should show involvement" do
    get :show, :id => involvements(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => involvements(:one).to_param
    assert_response :success
  end

  test "should update involvement" do
    put :update, :id => involvements(:one).to_param, :involvement => { }
    assert_redirected_to involvement_path(assigns(:involvement))
  end

  test "should destroy involvement" do
    assert_difference('Involvement.count', -1) do
      delete :destroy, :id => involvements(:one).to_param
    end

    assert_redirected_to involvements_path
  end
end
