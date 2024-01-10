# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :set_search
  protect_from_forgery with: :null_session
end
