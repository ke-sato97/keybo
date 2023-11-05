class CommentsController < ApplicationController
  def index; end

  def new
    @comment = Comment.new
  end

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to keyboard_path(comment.keyboard), success: "コメントしました"
    else
      redirect_to keyboard_path(comment.keyboard), danger: "コメントに失敗しました"
    end
  end

  def show; end

  def edit; end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(keyboard_id: params[:keyboard_id])
  end
end
