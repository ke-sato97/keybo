class UserMailer < ApplicationMailer
  default from: Rails.application.credentials.gmail[:user_name]  #Gmailアドレス（credentials.yml.encに記載）
  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email, subject: 'パスワードリセット')
  end
end
