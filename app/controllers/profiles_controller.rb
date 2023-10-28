class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update image_processing]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to profile_path
    else
      flash[:danger] = "プロフィールを更新できませんでした"
      render :edit
    end
  end

  def image_processing
    if request.patch?
      if params[:user][:image]
        # 画像を更新
        @user.image.purge if @user.image.attached?  # 既存の画像を削除
        @user.image.attach(params[:user][:image])
        flash[:success] = "画像が更新されました"
        redirect_to profile_path
      elsif params[:user][:remove_image]
        # 画像を削除
        @user.image.purge
        flash[:success] = "画像が削除されました"
        redirect_to profile_path
      end
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end
end
