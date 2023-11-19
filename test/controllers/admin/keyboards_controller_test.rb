# frozen_string_literal: true

require 'test_helper'

module Admin
  class KeyboardsControllerTest < ActionDispatch::IntegrationTest
    test 'should get search' do
      get admin_keyboards_search_url
      assert_response :success
    end

    test 'should get edit' do
      get admin_keyboards_edit_url
      assert_response :success
    end
  end
end
