class UserSessionsController < ApplicationController
  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to(:root, success: t('.success'))
    else
      flash.now[:danger] = t('.fail')
      redirect_to action: 'new'
    end
  end

  def guest_login
    redirect_to root_path, alert: 'すでにログインしています' if current_user # ログインしてる場合はユーザーを作成しない

    random_value = SecureRandom.hex
    user = User.create!(name: 'ゲスト', email: "test_#{random_value}@example.com", password: "#{random_value}",
                        password_confirmation: "#{random_value}", role: :guest)
    auto_login(user)
    redirect_to root_path, success: 'ゲストとしてログインしました'
  end

  def destroy
    logout
    redirect_to root_path, notice: 'ログアウトしました'
  end
end
