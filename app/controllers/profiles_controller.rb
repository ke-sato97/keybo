class ProfilesController < ApplicationController
# app/controllers/profile_controller.rb
  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path,success: "ユーザーを更新しました"
    else
      flash.now[:danger] = "ユーザーを更新できませんでした"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :image) # ストロングパラメータにimage(画像カラム)を追加
  end
end
