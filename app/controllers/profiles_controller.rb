class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update image_processing]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'プロフィールを更新しました'
      redirect_to profile_path
    elsif user_params[:remove_image]
      # 画像を削除
      @user.image.purge
      flash[:success] = '画像が削除されました'
    else
      flash[:danger] = 'プロフィールを更新できませんでした'
      render :edit
    end
  end

  def image_processing
    return unless request.patch?

    @user = User.find(current_user.id)

    # フォームから送信されたデータを取得
    user_params = params[:user]

    if user_params
      if user_params[:image]
        # 画像を更新
        @user.image.attach(user_params[:image])
        flash[:success] = '画像が更新されました'
      elsif user_params[:remove_image]
        # 画像を削除
        @user.image.purge
        flash[:success] = '画像が削除されました'
      end
    end

    redirect_to profile_path
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end
end
