# frozen_string_literal: true

module Admin
  class UserSessionsController < Admin::BaseController
    skip_before_action :require_login, only: %i[new create]
    skip_before_action :check_admin, only: %i[new create]

    def new; end

    def create
      @user = login(params[:email], params[:password])
      if @user
        redirect_to admin_keyboards_search_path, success: t('.success')
      else
        flash.now[:danger] = t('.fail')
        redirect_to action: 'new'
      end
    end

    def destroy
      logout
      redirect_to admin_login_path, success: t('.success')
    end
  end
end
