require 'test_helper'

class MoneyRecordsControllerTest < ActionController::TestCase
  setup do
    @money_record = money_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:money_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create money_record" do
    assert_difference('MoneyRecord.count') do
      post :create, money_record: {  }
    end

    assert_redirected_to money_record_path(assigns(:money_record))
  end

  test "should show money_record" do
    get :show, id: @money_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @money_record
    assert_response :success
  end

  test "should update money_record" do
    patch :update, id: @money_record, money_record: {  }
    assert_redirected_to money_record_path(assigns(:money_record))
  end

  test "should destroy money_record" do
    assert_difference('MoneyRecord.count', -1) do
      delete :destroy, id: @money_record
    end

    assert_redirected_to money_records_path
  end
end
