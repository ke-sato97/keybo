class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def create
    @user = login(params[:email], (params[:password]))

    if @user
      redirect_back_or_to(:root, notice: t('.success'))
    else
      flash.now[:danger] = t('.fail')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: 'Logged out!')
  end
end
