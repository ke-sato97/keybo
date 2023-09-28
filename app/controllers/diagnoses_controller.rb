class DiagnosesController < ApplicationController
  before_action :require_login
  def index
    @diagnoses = current_user.diagnoses.includes(:keyboard).page(params[:page]).all.map(&:keyboard)
  end

  def new
    @diagnosis = Diagnosis.new
  end

  def create
    selected_price = params[:price]
    selected_os = params[:os]
    selected_size = params[:size]
    selected_layout = params[:layout]
    selected_switch = params[:switch]
    name = params[:name]

    if [selected_price, selected_os].any?(&:blank?)
      flash[:danger] =  "質問１と質問2は必須項目です"
      redirect_to action: "new"
      return
    end

    @selected_keyboard = select_keyboard(selected_price, selected_os, selected_size, selected_layout, selected_switch, name)

    if @selected_keyboard
      @diagnosis = current_user.diagnoses.build(keyboard: @selected_keyboard)
      if @diagnosis.save
        redirect_to diagnosis_path(@selected_keyboard), success: 'おすすめのキーボードが見つかりました'
      else
        flash.now[:danger] = '診断結果の保存に失敗しました'
        redirect_to action: "new"
      end
    else
      @diagnosis = Diagnosis.new
      flash[:danger] = '選択された条件に合うものは見つかりませんでした'
      redirect_to action: "new"
    end
  end

  def show
    @selected_keyboard = Keyboard.find(params[:id])
  end

  private

  def select_keyboard(selected_price, selected_os, selected_size, selected_layout, selected_switch, name)
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

    query = Keyboard.where("? = ANY (os) AND price >= ? AND price <= ?", selected_os, price.min, price.max)

    # パラメーターが空でない場合にのみ条件を追加
    query = query.where("name ILIKE ?", "%#{name}%") if name.present?
    query = query.where("size = ?", selected_size) if selected_size.present?
    query = query.where("layout = ?", selected_layout) if selected_layout.present?
    query = query.where("switch = ?", selected_switch) if selected_switch.present?

    keyboard = query.order("RANDOM()").first
    keyboard
  end

  def not_authenticated
    redirect_to login_path, alert: "ログインしてください"
  end
end

