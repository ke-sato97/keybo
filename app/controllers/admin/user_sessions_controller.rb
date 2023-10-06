class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to admin_keyboards_search_path, success: '管理者としてログインしました'
    else
      flash.now[:danger] = '管理者のログインに失敗しました'
      redirect_to action: 'new'
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, success: 'ログアウトしました'
  end
end
