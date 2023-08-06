class KeyboardsController < ApplicationController
  def index
    @keyboards = Keyboard.new
  end

  def new
  end

  def show
  end

  def edit
  end

def search
  @keyboards = []
  @model = params[:keyword]
  if @model.present?
    results = RakutenWebService::Ichiba::Item.search(keyword: @model)
    results.each do |result|
      keyboard = Keyboard.new(read(result))
      @keyboards << keyboard
    end
  end
  @keyboards.each do |keyboard|
    unless Keyboard.all.include?(keyboard)
      keyboard.save
    end
  end
end

  private

  def read(result)
    model = result["itemName"]
    brand = result["shopCode"]
    price = result["itemPrice"]
    size = result["itemCaption"]
    os = result["catchcopy"]
    # layout = result[""]
    # switch = result[""]
    {
      model: model,
      brand: brand,
      price: price,
      size: size,
      os: os,
      # layout: layout,
      # switch: switch,
    }
  end
end
