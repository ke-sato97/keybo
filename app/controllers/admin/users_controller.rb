module Admin
  class Admin::UsersController < Admin::BaseController
    before_action :set_user, only: %i[show edit update destroy]
    def index
      @users = User.all
    end

    def new
    end

    def show; end

    def edit
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, status: :see_other, success: 'ユーザーを削除しました'
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
