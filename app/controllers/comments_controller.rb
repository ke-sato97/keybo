class CommentsController < ApplicationController
  before_action :find_keyboard, only: %i[create edit]
  before_action :set_comment, only: %i[edit update destroy]

  def new; end

  def create
    @comment = @keyboard.comments.build(comment_params)
    if @comment.save
      flash.now.notice = "コメントを投稿しました。"
    else
      flash[:danter] = 'コメントできませんでした。'
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash.now.notice = "コメントを更新しました。"
      redirect_to keyboard_path(@comment.keyboard)
    else
      # バリデーションエラーの際はedit.html.erbを返す
      flash[:danter] = 'コメントを更新できませんでした。'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    flash.now.notice = "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end

  def find_keyboard
    params.each do |name, value|
      @keyboard = ::Regexp.last_match(1).classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    nil
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end
end

