module Admin
  class Admin::UsersController < Admin::BaseController
    before_action :set_user, only: %i[show edit update destroy]
    def index
      @users = User.all
    end

    def new
    end

    def show; end

    def edit; end

    def update
      binding.pry
      if @user.update(user_params)
        redirect_to @user, success: "ユーザー情報を更新しました"
      else
        redirect_to :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, status: :see_other, success: 'ユーザーを削除しました'
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirm)
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end
