require 'test_helper'

class MinicomputersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:minicomputers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create minicomputer" do
    assert_difference('Minicomputer.count') do
      post :create, :minicomputer => { }
    end

    assert_redirected_to minicomputer_path(assigns(:minicomputer))
  end

  test "should show minicomputer" do
    get :show, :id => minicomputers(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => minicomputers(:one).id
    assert_response :success
  end

  test "should update minicomputer" do
    put :update, :id => minicomputers(:one).id, :minicomputer => { }
    assert_redirected_to minicomputer_path(assigns(:minicomputer))
  end

  test "should destroy minicomputer" do
    assert_difference('Minicomputer.count', -1) do
      delete :destroy, :id => minicomputers(:one).id
    end

    assert_redirected_to minicomputers_path
  end
end
