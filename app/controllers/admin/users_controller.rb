module Admin
  class Admin::UsersController < Admin::BaseController
    before_action :set_user, only: %i[show edit update destory]
    def index
      @users = User.all
    end

    def new
    end

    def show; end

    def edit
    end

    def destory
      @user.destory
      redirect_to admin_users_path, success: 'ユーザーを削除しました'
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
