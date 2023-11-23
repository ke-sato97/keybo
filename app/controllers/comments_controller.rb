# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_keyboard, only: %i[create edit]
  before_action :set_comment, only: %i[show edit update destroy]

  def show; end
  def new; end

  def edit; end

  def create
    @comment = @keyboard.comments.build(comment_params)
    if @comment.save
      # flash.now.notice = 'コメントを投稿しました。'
      flash[:success] = 'コメントしました'
      redirect_to keyboard_path(@comment.keyboard)
    else
      flash[:danger] = 'コメントできませんでした'
      redirect_to keyboard_path(@comment.keyboard)
      # redirect_to action: 'new'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to keyboard_path(@comment.keyboard)
    else
      # バリデーションエラーの際はedit.html.erbを返す
      flash[:danter] = 'コメントを更新できませんでした'
      redirect_to action: 'edit'
    end
  end

  def destroy
    @comment.destroy
    # redirect_to keyboard_path(@comment.keyboard)
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
