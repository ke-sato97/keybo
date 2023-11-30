# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  def new; end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    return if @user.present?

    not_authenticated
    nil
  end

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    flash[:success] = t('.success')
    redirect_to login_path
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
      flash[:success] = t('.success')
      redirect_to login_path
    else
      flash[:danger] = t('.fail')
      redirect_to action: 'edit'
    end
  end
end
