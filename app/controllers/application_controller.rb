class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @keyboards = if params[:search].present?
                   Keyboard.where('name ILIKE ?', "%#{params[:search]}%")
                 else
                   []
                 end

    respond_to do |format|
      format.html
      format.json { render json: @keyboards.pluck(:name) }
    end
  end
end
