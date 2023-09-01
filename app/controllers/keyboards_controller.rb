class KeyboardsController < ApplicationController
  def index
    if params[:tag_id].present?
      tag = Tag.find(params[:tag_id])
      @keyboards = tag.keyboards.includes(:tags)
    else
      @keyboards = Keyboard.includes(:tags).all
    end
  end

  def new
  end

  def show
    @keyboard = Keyboard.find(params[:id])
    @tags = @keyboard.tags
  end

  def edit
  end

  def search
    @keyboards = []
    @model = params[:keyword]
    if @model.present?
      results = RakutenWebService::Ichiba::Item.search(keyword: @model, hits: 5 )
      results.each do |result|
        keyboard = Keyboard.new(read(result))
        @keyboards << keyboard
      end
    end
    @keyboards.each do |keyboard|
      unless Keyboard.all.include?(keyboard)
        keyboard.save
      end

      tag_names = create_tag_from_caption(keyboard.caption)
      if tag_names.present?
        tag_names.each do |tag_name|
          tag = Tag.find_or_create_by(name: tag_name)
          keyboard.tags << tag
        end
      end
    end
    @keyboards_with_tags = Keyboard.includes(:tags).where(id: @keyboards.map(&:id))
  end

  private

  def keyboard_params
    params.require(:keyboard).permit(:image, :model, :brand, :price, :size, :switch, :layout, :os)
  end

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
    return matches.flatten.uniq if matches.any?
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

  def create_tag_from_caption(caption)
    tag_pattern = /(108キー日本語レイアウト|US配列|日本語配列|英語配列|メンブレン|メカニカル|パンタグラフ|静電容量無接点)/

    matches = caption.scan(tag_pattern)
    return matches.flatten.uniq if matches.any?
    # return matches if matches.any?
    nil
  end
end
