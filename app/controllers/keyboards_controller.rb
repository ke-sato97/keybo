class KeyboardsController < ApplicationController
  def index
    @keyboards = Keyboard.all(keyboard_params)
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
    caption = result["itemCaption"]
    size = extract_size_from_caption(caption)
    switch = extract_switch_from_caption(caption)
    layout = extract_layout_from_caption(caption)
    os = extract_os_from_caption(caption)
    {
      model: model,
      brand: brand,
      price: price,
      caption: caption,
      size: size,
      os: os,
      layout: layout,
      switch: switch,
    }
  end

  def keyboard_params
    params.require(:keyboard).permit(:model, :brand, :price, :size, :switch, :layout, :os)
  end

end
