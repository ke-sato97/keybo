# frozen_string_literal: true

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
    elsif current_user&.admin?
      @keyboards = Keyboard.includes(:tags).all.page(params[:page])
    else
      head :no_content
    end
  end

  def show
    @keyboard = Keyboard.find(params[:id])
    @comment = Comment.new
    @comments = @keyboard.comments.includes(:user).order(created_at: :asc)
    @tags = @keyboard.tags
    @recommended_keyboards = RecommendationService.new.recommend_keyboards(@keyboard)
  end

  def bookmarks
    @bookmarks_keyboards = current_user.bookmark_keyboards.includes(:user).order(create_at: :desc)
  end

  def ranks
    @bookmark_ranks = Keyboard.bookmark_ranks
    @comment_ranks = Keyboard.comment_ranks
    @diagnosis_ranks = Keyboard.diagnosis_ranks
  end

  def type_search
    # ページネーションを適用する前に、ユーザーの診断履歴を取得
    @search_query = params[:query]
    @found_keyboards = Keyboard.none

    if @search_query.present?
      @found_keyboards = Keyboard.where("size LIKE :query OR layout LIKE :query OR switch LIKE :query", query: "%#{@search_query}%").includes(:tags).page(params[:page])
    end
  end
end
