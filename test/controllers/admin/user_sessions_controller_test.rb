# frozen_string_literal: true

require 'test_helper'

module Admin
  class UserSessionsControllerTest < ActionDispatch::IntegrationTest
    test 'should get new' do
      get admin_user_sessions_new_url
      assert_response :success
    end
  end
end
