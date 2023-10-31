class BookmarksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    # ページネーションを適用する前に、ユーザーの診断履歴を取得
    @keyboards = current_user.bookmarks.includes(:keyboard).page(params[:page])
    @bookmarks = @keyboards.all.order(created_at: :desc).map(&:keyboard)
  end

  def create
    @keyboard = Keyboard.find(params[:keyboard_id])
    current_user.bookmark(@keyboard)
    redirect_back fallback_location: keyboards_path
  end

  def destroy
    @keyboard = current_user.bookmarks.find(params[:id]).keyboard
    current_user.unbookmark(@keyboard)
    redirect_back fallback_location: keyboards_path
  end
end
