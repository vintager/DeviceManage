require 'test_helper'

class ComputerDetailsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:computer_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create computer_detail" do
    assert_difference('ComputerDetail.count') do
      post :create, :computer_detail => { }
    end

    assert_redirected_to computer_detail_path(assigns(:computer_detail))
  end

  test "should show computer_detail" do
    get :show, :id => computer_details(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => computer_details(:one).id
    assert_response :success
  end

  test "should update computer_detail" do
    put :update, :id => computer_details(:one).id, :computer_detail => { }
    assert_redirected_to computer_detail_path(assigns(:computer_detail))
  end

  test "should destroy computer_detail" do
    assert_difference('ComputerDetail.count', -1) do
      delete :destroy, :id => computer_details(:one).id
    end

    assert_redirected_to computer_details_path
  end
end
