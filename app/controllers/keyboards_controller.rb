class KeyboardsController < ApplicationController
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
  end
end
