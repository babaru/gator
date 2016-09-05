require 'test_helper'

class TrustorsControllerTest < ActionController::TestCase
  setup do
    @trustor = trustors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trustors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trustor" do
    assert_difference('Trustor.count') do
      post :create, trustor: {  }
    end

    assert_redirected_to trustor_path(assigns(:trustor))
  end

  test "should show trustor" do
    get :show, id: @trustor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trustor
    assert_response :success
  end

  test "should update trustor" do
    patch :update, id: @trustor, trustor: {  }
    assert_redirected_to trustor_path(assigns(:trustor))
  end

  test "should destroy trustor" do
    assert_difference('Trustor.count', -1) do
      delete :destroy, id: @trustor
    end

    assert_redirected_to trustors_path
  end
end
