require 'test_helper'

class 200kForSmasControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => 200kForSMA.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    200kForSMA.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    200kForSMA.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to 200k_for_sma_url(assigns(:200k_for_sma))
  end
  
  def test_edit
    get :edit, :id => 200kForSMA.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    200kForSMA.any_instance.stubs(:valid?).returns(false)
    put :update, :id => 200kForSMA.first
    assert_template 'edit'
  end
  
  def test_update_valid
    200kForSMA.any_instance.stubs(:valid?).returns(true)
    put :update, :id => 200kForSMA.first
    assert_redirected_to 200k_for_sma_url(assigns(:200k_for_sma))
  end
  
  def test_destroy
    200k_for_sma = 200kForSMA.first
    delete :destroy, :id => 200k_for_sma
    assert_redirected_to 200k_for_smas_url
    assert !200kForSMA.exists?(200k_for_sma.id)
  end
end
