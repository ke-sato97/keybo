class DiagnosesController < ApplicationController
  before_action :require_login
  def index
    @diagnoses = current_user.diagnoses.includes(:keyboard).all
  end

  def new
    @diagnosis = Diagnosis.new
  end

  def create
    selected_price = params[:price]
    selected_os = params[:os]
    selected_layout = params[:layout]
    name = params[:name]

    if [selected_price, selected_os, selected_layout].any?(&:blank?)
      flash[:danger] =  "選択していない項目があります"
      redirect_to action: "new"
      return
    end

    @selected_keyboard = select_keyboard(selected_price, selected_os, selected_layout, name)

    if @selected_keyboard
      binding.pry
      @diagnosis = current_user.diagnoses.build(keyboard: @selected_keyboard)
      if @diagnosis.save
        redirect_to diagnosis_path(@selected_keyboard)
      else
        flash.now[:notice] = '診断結果の保存に失敗しました'
        redirect_to action: "new"
      end
    else
      @diagnosis = Diagnosis.new
      flash[:notice] = '選択された条件に合うものは見つかりませんでした'
      redirect_to action: "new"
    end
  end

  def show
    @selected_keyboard = Keyboard.find(params[:id])
  end

  private

  def select_keyboard(selected_price, selected_os, selected_layout, name)
    price = case selected_price
                      when '0-5000'
                        0..5000
                      when '5000-10000'
                        5000..10000
                      when '10000-15000'
                        10000..15000
                      when '15000-20000'
                        15000..20000
                      when '20000+'
                        20000..999999
                      else
                        nil
                      end

    # name パラメーターが空でない場合にのみ name 条件を追加
    query = Keyboard.where("? = ANY (os) AND layout = ? AND price >= ? AND price <= ?", selected_os, selected_layout, price.min, price.max)
    query = query.where("name ILIKE ?", "%#{name}%") if name.present?
    keyboard = query.order("RANDOM()").first

    keyboard
  end

  def not_authenticated
    redirect_to login_path, alert: "ログインしてください"
  end
end

