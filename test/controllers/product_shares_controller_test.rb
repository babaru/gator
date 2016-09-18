require 'test_helper'

class ProductSharesControllerTest < ActionController::TestCase
  setup do
    @product_share = product_shares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_shares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_share" do
    assert_difference('ProductShare.count') do
      post :create, product_share: {  }
    end

    assert_redirected_to product_share_path(assigns(:product_share))
  end

  test "should show product_share" do
    get :show, id: @product_share
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_share
    assert_response :success
  end

  test "should update product_share" do
    patch :update, id: @product_share, product_share: {  }
    assert_redirected_to product_share_path(assigns(:product_share))
  end

  test "should destroy product_share" do
    assert_difference('ProductShare.count', -1) do
      delete :destroy, id: @product_share
    end

    assert_redirected_to product_shares_path
  end
end
