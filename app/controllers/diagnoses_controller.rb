class DiagnosesController < ApplicationController
  before_action :require_login
  def index
    # ページネーションを適用する前に、ユーザーの診断履歴を取得
    @keyboards = current_user.diagnoses.includes(:keyboard).page(params[:page])
    @diagnoses = @keyboards.all.order(created_at: :desc).map(&:keyboard)
  end

  def new
    @diagnosis = Diagnosis.new
  end

  def create
    price = params[:price]
    os = params[:os]
    size = params[:size]
    layout = params[:layout]
    switch = params[:switch]
    connect = params[:connect]
    name = params[:name]

    if [price].any?(&:blank?)
      flash[:danger] = '質問１は必須項目です'
      redirect_to action: 'new'
      return
    end

    @selected_keyboard = select_keyboard(price, os, size, layout, switch, connect, name)

    if @selected_keyboard
      @diagnosis = current_user.diagnoses.build(keyboard: @selected_keyboard)
      if @diagnosis.save
        redirect_to diagnosis_path(@selected_keyboard), success: 'おすすめのキーボードが見つかりました'
      else
        flash.now[:danger] = '診断結果の保存に失敗しました'
        redirect_to action: 'new'
      end
    else
      @diagnosis = Diagnosis.new
      flash[:danger] = '選択された条件に合うものは見つかりませんでした'
      redirect_to action: 'new'
    end
  end

  def show
    @selected_keyboard = Keyboard.find(params[:id])
  end

  private

  def select_keyboard(price, os, size, layout, _switch, connect, _name)
    price_case = case price
                 when '0-5000'
                   0..5000
                 when '5000-10000'
                   5000..10_000
                 when '10000-15000'
                   10_000..15_000
                 when '15000-20000'
                   15_000..20_000
                 when '20000-30000'
                   20_000..30_000
                 when '30000+'
                   30_000..999_999
                 end

    query = Keyboard.where('price >= ? AND price <= ?', price_case.min, price_case.max)

    # パラメーターが空でない場合にのみ条件を追加
    query = query.where('? = ANY (os)', os) if os.present?
    query = query.where('size = ?', size) if size.present?
    query = query.where('layout = ?', layout) if layout.present?
    # query = query.where("switch = ?", switch) if switch.present?
    query = query.where('? = ANY (connect)', connect) if connect.present?
    # query = query.where("name ILIKE ?", "%#{name}%") if name.present?

    query.order('RANDOM()').first
  end

  def not_authenticated
    redirect_to login_path, alert: 'ログインしてください'
  end
end
