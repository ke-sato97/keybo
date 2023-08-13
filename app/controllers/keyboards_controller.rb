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
    image = result["mediumImageUrls"].first
    model = result["itemName"]
    brand = result["shopCode"]
    price = result["itemPrice"]
    caption = result["itemCaption"]
    size = extract_size_from_caption(caption)
    switch = extract_switch_from_caption(caption)
    layout = extract_layout_from_caption(caption)
    os = extract_os_from_caption(caption)
    {
      image: image,
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

  def extract_size_from_caption(caption)
    size_pattern = /(フルサイズ|75%|60%|110キー|108キー|110%)/
    match = caption.match(size_pattern)
    return match[0] if match
    nil
  end

  def extract_os_from_caption(caption)
    os_pattern = /(MacOS|macOS|Windows 10|Windows 11|Chrome OS)/i
    matches = caption.scan(os_pattern)
    return matches if matches.any?
    nil
  end

  def extract_layout_from_caption(caption)
    layout_pattern = /(日本語配列|英語配列|JIS配列|US配列|日本語レイアウト)/
    match = caption.match(layout_pattern)
    return match[0] if match
    nil
  end

  def extract_switch_from_caption(caption)
    switch_pattern = /(メンブレン|パンタグラフ|メカニカルキーボード|静電容量無接点)/
    match = caption.match(switch_pattern)
    return match[0] if match
    nil
  end

  def keyboard_params
    params.require(:keyboard).permit(:model, :brand, :price, :size, :switch, :layout, :os)
  end

end
