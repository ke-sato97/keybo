# frozen_string_literal: true

class UserSessionsController < ApplicationController
  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to(:root, success: t('.success'))
    else
      flash[:danger] = t('.fail')
      redirect_to action: 'new'
    end
  end

  def guest_login
    redirect_to root_path, alert: t.call('.fail') if current_user # ログインしてる場合はユーザーを作成しない

    random_value = SecureRandom.hex
    user = User.create!(name: 'ゲスト', email: "test_#{random_value}@example.com", password: random_value.to_s,
                        password_confirmation: random_value.to_s, role: :guest)
    auto_login(user)
    redirect_to root_path, success: t('.success')
  end

  def destroy
    logout
    redirect_to root_path, success: t('.success')
  end
end
