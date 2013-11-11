require 'test_helper'

class HomepageControllerTest < ActionController::TestCase
  test "should get show" do
    sign_in FactoryGirl.create(:employee)
    get :show
    assert_response :success
  end

end
