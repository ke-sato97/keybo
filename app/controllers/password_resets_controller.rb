class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by_email(params[:email])
    @user&.deliver_reset_password_instructions!
    flash[:success] = 'パスワードリセット手順を送信しました。メールをご確認ください。'
    redirect_to login_path
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    return unless @user.blank?

    not_authenticated
    nil
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      flash[:success] = 'パスワードを変更しました'
      redirect_to login_path
    else
      flash[:danger] = 'パスワードの変更に失敗しました'
      redirect_to action: 'edit'
    end
  end
end
