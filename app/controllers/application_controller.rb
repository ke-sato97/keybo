class ApplicationController < ActionController::Base
  # before_action :require_login
  before_action :set_search

  def set_search
    if params[:search].present?
      @keyboards = Keyboard.where('name LIKE ?', "%#{params[:search]}%")
    else
      @keyboards = []
    end

    respond_to do |format|
      format.html
      format.json { render json: @keyboards.pluck(:name) }
    end
  end

  # private

  # def not_authenticated
  #   redirect_to login_path, alert: "Please login first"
  # end
end
