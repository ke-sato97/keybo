class KeyboardsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:tag_id].present?
      tag = Tag.find(params[:tag_id])
      @keyboards = tag.keyboards.includes(:tags).page(params[:page])
    elsif params[:search].present?
      @keyboards = Keyboard.where('name ILIKE ?', "%#{params[:search]}%")
                           .includes(:tags)
                           .page(params[:page])
    elsif current_user && current_user.admin?
      @keyboards = Keyboard.includes(:tags).all.page(params[:page])
    else
      head :no_content
    end
  end

  def show
    @keyboard = Keyboard.find(params[:id])
    @tags = @keyboard.tags
    @comment = Comment.new
    @comments = @keyboard.comments.includes(:user).order(created_at: :asc)
  end

  def bookmarks
    @bookmarks_keyboards = current_user.bookmark_keyboards.includes(:user).order(create_at: :desc)
  end
end
