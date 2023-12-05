# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :require_login
    before_action :check_admin
    layout 'admin/layouts/application'

    private

    def not_authenticated
      flash[:danger] = t('defaults.message.require_login')
      redirect_to root_path
    end

    def check_admin
      redirect_to root_path, danger: '管理者権限がありません' unless current_user.admin?
    end
  end
end
