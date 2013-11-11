require 'test_helper'

class FramesControllerTest < ActionController::TestCase
  setup do
    sign_in FactoryGirl.create(:employee)
    @frame = FactoryGirl.create(:frame)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:frames)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create frame" do
    assert_difference('Frame.count') do
      post :create, frame: { brand_id: @frame.brand_id, name: @frame.name }
    end

    assert_redirected_to frame_path(assigns(:frame))
  end

  test "should show frame" do
    get :show, id: @frame
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @frame
    assert_response :success
  end

  test "should update frame" do
    patch :update, id: @frame, frame: { brand_id: @frame.brand_id, name: @frame.name }
    assert_redirected_to frame_path(assigns(:frame))
  end

  test "should destroy frame" do
    assert_difference('Frame.count', -1) do
      delete :destroy, id: @frame
    end

    assert_redirected_to frames_path
  end
end
