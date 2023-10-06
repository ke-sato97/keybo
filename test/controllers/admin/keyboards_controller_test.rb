require 'test_helper'

class Admin::KeyboardsControllerTest < ActionDispatch::IntegrationTest
  test 'should get search' do
    get admin_keyboards_search_url
    assert_response :success
  end

  test 'should get edit' do
    get admin_keyboards_edit_url
    assert_response :success
  end
end
