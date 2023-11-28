# frozen_string_literal: true

class BookmarksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @keyboards = current_user.bookmarks.includes(:keyboard).page(params[:page])
    @bookmarks = @keyboards.order(created_at: :desc).map(&:keyboard)
  end

  def create
    @keyboard = Keyboard.find(params[:keyboard_id])
    current_user.bookmark(@keyboard)
    redirect_to keyboard_path(@keyboard)
    flash.now[:success] = 'お気に入り登録しました'
  end

  def destroy
    @keyboard = current_user.bookmarks.find(params[:id]).keyboard
    current_user.unbookmark(@keyboard)
    redirect_to keyboard_path(@keyboard)
    # redirect_back fallback_location: keyboards_path
    flash.now[:success] = 'お気に入りを解除しました'
  end
end
