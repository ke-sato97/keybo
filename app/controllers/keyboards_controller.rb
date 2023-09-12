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

        keyboard = Keyboard.new(keyboard_info)
        @keyboards << keyboard
      end
    end
    @keyboards.each do |keyboard|
      unless Keyboard.all.include?(keyboard)
        keyboard.save
      end

      tag_names = create_tag_from_name_and_caption(keyboard.name) || create_tag_from_name_and_caption(keyboard.caption)

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
    os = create_os_from_caption(caption)
    size = create_size_from_name_and_caption(name) || create_size_from_name_and_caption(caption)
    switch = create_switch_from_caption(caption)
    layout = create_layout_from_caption(caption)
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

  # 以下APIから受け取ったデータを加工
  # nameカラムに送られてくるAPIからのデータを編集
  def remove_brackets(text)
    text.gsub(/\【.*?\】|＼.*?／|＼.*?／|\b(国内正規品|&限定価格&ポイント2倍&クーポン |正規保証品|正規保証|12ヶ月安心保証|1年間無償保証|2年間無償保証|3年間無償保証|送料無料|新生活)\b/, "")
  end

  # OS
  def create_os_from_caption(caption)
    os_pattern = /(MacOS|macOS|Windows|windows|Linux|linux|Chrome OS|iOS|Android)/i
    matches = caption.scan(os_pattern)

    if matches.any?
      normalized_os = matches.flatten.uniq.map(&:downcase)
      return normalized_os
    end
    nil
  end

  # size
  def create_size_from_name_and_caption(text)
    size_pattern = /(フルサイズ|テンキーレス|60%|70%|75%|80%|100%|110%|67キー|92キー|104 キー|106キー|107キー|108キー|109キー|110キー|111キー|112キー)/
    match = text.match(size_pattern)
    return match[0] if match
    nil
  end

  # switch
  def create_switch_from_caption(caption)
    switch_pattern = /(メンブレン|パンタグラフ|メカニカルキーボード|静電容量無接点)/
    match = caption.match(switch_pattern)
    return match[0] if match
    nil
  end

  # layout
  def create_layout_from_caption(caption)
    layout_pattern = /(日本語配列|英語配列|JIS配列|US配列|日本語レイアウト)/
    match = caption.match(layout_pattern)
    return match[0] if match
    nil
  end

  # タグを作成
  def create_tag_from_name_and_caption(text)
    tag_pattern = /(フルサイズ|テンキーレス|60%|70%|75%|80%|100%|110%|67キー|92キー|106キー|107キー|108キー|109キー|110キー|111キー|112キー|日本語レイアウト|US配列|日本語配列|英語配列|MacOS|macOS|Windows|Linux|メンブレン|メカニカル|パンタグラフ|静電容量無接点)/

    matches = text.scan(tag_pattern)
    return matches.flatten.uniq if matches.any?
    # return matches if matches.any?
    nil
  end
end
