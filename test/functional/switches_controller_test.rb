require 'test_helper'

class SwitchesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:switches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create switch" do
    assert_difference('Switch.count') do
      post :create, :switch => { }
    end

    assert_redirected_to switch_path(assigns(:switch))
  end

  test "should show switch" do
    get :show, :id => switches(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => switches(:one).id
    assert_response :success
  end

  test "should update switch" do
    put :update, :id => switches(:one).id, :switch => { }
    assert_redirected_to switch_path(assigns(:switch))
  end

  test "should destroy switch" do
    assert_difference('Switch.count', -1) do
      delete :destroy, :id => switches(:one).id
    end

    assert_redirected_to switches_path
  end
end
