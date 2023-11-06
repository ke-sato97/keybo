class CommentsController < ApplicationController
  before_action :find_keyboard, only: %i[create edit]
  before_action :find_comment, only: %i[edit update destroy]

  def new; end

  def create
    @comment = @keyboard.comments.build(comment_params)
    respond_to do |format|
      binding.pry
      if @comment.save
        format.turbo_stream { flash[:success] = "コメントしました" }
        format.html { redirect_to @comment.keyboard,
                      flash: { success: "コメントしました" } }
      else
        format.turbo_stream do
          flash[:danger] = "コメントに失敗しました"
          render turbo_stream: [
            turbo_stream.replace("flash_message", partial: "shared/flash_message"),
          ]
        end
        format.html { redirect_to @comment.keyboard,
                      flash: { danger: "コメントに失敗しました" } }
      end
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream { flash[:success] = "コメントを編集しました" }
        format.html { redirect_to @comment.keyboard,
                      flash: { success: "コメントを編集しました" } }
      else
        format.turbo_stream do
          flash[:warning] = "コメントの編集にしっぱいしました"
          render turbo_stream: [
            turbo_stream.replace("flash_message", partial: "shared/flash_message"),
          ]
        end
        format.html { redirect_to @comment.keyboard,
                      flash: { danger: "コメントの編集にしっぱいしました" } }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.turbo_stream { flash[:success] = "コメントを削除しました" }
      format.html { redirect_to @comment.keyboard,
                    flash: { success: "コメントを削除しました" } }
    end
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

  def find_comment
    @comment = current_user.comments.find(params[:id])
  end
end

