class BookmarksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @keyboard = Keyboard.find(params[:keyboard_id])
    current_user.bookmark(@keyboard)
  end

  def destroy
    @keyboard = current_user.bookmarks.find(params[:id]).keyboard
    current_user.unbookmark(@keyboard)
  end
end
