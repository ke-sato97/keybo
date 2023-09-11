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
    @name = params[:keyword]
    if @name.present?
      results = RakutenWebService::Ichiba::Item.search(keyword: @name, hits: 15 )

      results.each do |result|
        keyboard_info = read(result)
        name_without_brackets = remove_brackets(keyboard_info[:name]) # 商品名から【】及び【】内の文字列を削除
        keyboard_info[:name] = name_without_brackets # 更新した商品名を設定

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

  def read(result)
    medium_image_urls = result["mediumImageUrls"]
    name = result["itemName"]
    brand = result["shopCode"]
    price = result["itemPrice"]
    caption = result["itemCaption"]
    size = extract_size_from_caption(caption)
    switch = extract_switch_from_caption(caption)
    layout = extract_layout_from_caption(caption)
    os = extract_os_from_caption(caption)
    {
      medium_image_urls: medium_image_urls,
      name: name,
      brand: brand,
      price: price,
      caption: caption,
      size: size,
      os: os,
      layout: layout,
      switch: switch,
    }
  end

  def remove_brackets(text)
    text.gsub(/\【.*?\】|＼.*?／|＼.*?／|\b(国内正規品|&限定価格&ポイント2倍&クーポン |正規保証品|正規保証|12ヶ月安心保証|1年間無償保証|2年間無償保証|3年間無償保証|送料無料|新生活)\b/, "")
  end

  def extract_size_from_caption(caption)
    size_pattern = /(フルサイズ|テンキーレス|75%|60%|110キー|108キー|110%)/
    match = caption.match(size_pattern)
    return match[0] if match
    nil
  end

  def extract_os_from_caption(caption)
    os_pattern = /(MacOS|macOS|Windows|windows|Chrome OS|iOS|Android)/i
    matches = caption.scan(os_pattern)

    if matches.any?
      normalized_os = matches.flatten.uniq.map(&:downcase)
      return normalized_os
    end
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
    tag_pattern = /(108キー日本語レイアウト|US配列|日本語配列|英語配列|MacOS|macOS|Windows|メンブレン|メカニカル|パンタグラフ|静電容量無接点)/

    matches = caption.scan(tag_pattern)
    return matches.flatten.uniq if matches.any?
    # return matches if matches.any?
    nil
  end
end
