class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    if params[:search].present?
      @keyboards = Keyboard.where('name ILIKE ?', "%#{params[:search]}%")
    else
      @keyboards = []
    end

    respond_to do |format|
      format.html
      format.json { render json: @keyboards.pluck(:name) }
    end
  end
end
