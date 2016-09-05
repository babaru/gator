require 'test_helper'

class SecuritiesBrokersControllerTest < ActionController::TestCase
  setup do
    @securities_broker = securities_brokers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:securities_brokers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create securities_broker" do
    assert_difference('SecuritiesBroker.count') do
      post :create, securities_broker: {  }
    end

    assert_redirected_to securities_broker_path(assigns(:securities_broker))
  end

  test "should show securities_broker" do
    get :show, id: @securities_broker
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @securities_broker
    assert_response :success
  end

  test "should update securities_broker" do
    patch :update, id: @securities_broker, securities_broker: {  }
    assert_redirected_to securities_broker_path(assigns(:securities_broker))
  end

  test "should destroy securities_broker" do
    assert_difference('SecuritiesBroker.count', -1) do
      delete :destroy, id: @securities_broker
    end

    assert_redirected_to securities_brokers_path
  end
end
