class CommentsController < ApplicationController
  before_action :find_keyboard, only: %i[create edit]
  before_action :find_comment, only: %i[edit update destroy]

  def create
    @comment = @keyboard.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream { }
        format.html { redirect_to @comment.keyboard }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('flash_messages', partial: 'shared/flash_messages')
          ]
        end
        format.html { redirect_to @comment.keyboard }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream 
        format.html do
          redirect_to @comment.keyboard
        end
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('flash_messages', partial: 'shared/flash_messages')
          ]
        end
        format.html do
          redirect_to @comment.keyboard
        end
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.turbo_stream 
      format.html do
        redirect_to @comment.keyboard
      end
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
