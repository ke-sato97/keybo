class Admin::KeyboardsController < Admin::BaseController
  def search
    @keyboards = []
    @name = params[:keyword]
    if @name.present?
      # APIにリクエストを送信
      results = RakutenWebService::Ichiba::Item.search(keyword: @name, hits: 20 )

      # レスポンスを処理
      results.each do |result|
        keyboard_info = read(result)
        name_without_brackets = remove_brackets(keyboard_info[:name]) # 商品名からremove_brackets内の文字列を削除
        keyboard_info[:name] = name_without_brackets # 更新した商品名を設定

        existing_keyboard = Keyboard.find_by(name: keyboard_info[:name])

        if existing_keyboard
          # 既存のキーボードが存在する場合は更新
          existing_keyboard.update(keyboard_info)
        else
          # 既存のキーボードが存在しない場合は新規保存
          existing_keyboard = Keyboard.new(keyboard_info)
          existing_keyboard.save
        end

        # タグの作成と関連付け
        create_and_assign_tags(keyboard_info, existing_keyboard)
      end
    end
  end

  def edit; end

  private

  # 各カラムに振り分け
  def read(result)
    medium_image_urls = result["mediumImageUrls"]
    name = result["itemName"]
    brand = result["shopCode"]
    price = result["itemPrice"]
    caption = result["itemCaption"]
    os = create_os_from_name_and_caption(name) || create_os_from_name_and_caption(caption)
    size = create_size_from_name_and_caption(name) || create_size_from_name_and_caption(caption)
    switch = create_switch_from_name_and_caption(name) || create_switch_from_name_and_caption(caption)
    layout = create_layout_from_name_and_caption(name) || create_layout_from_name_and_caption(caption)
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
    text.gsub(/\【.*?\】|＼.*?／|[.*?]|\b(国内正規品|着日指定不可|&限定価格&ポイント2倍&クーポン |正規保証品|正規保証|12ヶ月安心保証|一年間品質保証|ギフト|お誕生日|★即納|誕生日プレゼント|人気ギフト|贈り物|敬老の日|1年間無償保証|2年間無償保証|3年間無償保証|★絶賛発売中|送料無料|新生活)\b/, "")
  end

  # osカラムに保存する文字列(全て小文字に変換し配列にして保存)
  def create_os_from_name_and_caption(text)
    os_pattern = /(Mac|mac|Windows|windows|Linux|linux|Chrome OS|iOS|Android)/i
    matches = text.scan(os_pattern)

    if matches.any?
      normalized_os = matches.flatten.uniq.map(&:downcase)
      return normalized_os
    end
    nil
  end

  # sizeカラムに保存する文字列
  def create_size_from_name_and_caption(text)
    size_pattern = /(テンキーレス|テンキーなし|テンキー付き|フルサイズ|60%|70%|75%|80%|100%|110%|66キー|67キー|84キー|92キー|104 キー|105キー|106キー|107キー|108キー|109キー|110キー|111キー|112キー|113キー|114キー|115キー)/
    match = text.match(size_pattern)
    return match[0].gsub(/(テンキーレス|テンキーなし|60%|70%|75%|80%|66キー|67キー|84キー|92キー)/, "テンキーレス").gsub(/(テンキー付き|フルサイズ|100%|110%|105キー|106キー|107キー|108キー|109キー|110キー|111キー|112キー|113キー|114キー|115キー)/, "フルサイズ") if match
    nil
  end

  # switchカラムに保存する文字列
  def create_switch_from_name_and_caption(text)
    switch_pattern = /(メンブレン|パンタグラフ|メカニカル|静電容量無接点)/
    match = text.match(switch_pattern)
    return match[0] if match
    nil
  end

  # layoutカラムに保存する文字列
  def create_layout_from_name_and_caption(text)
    layout_pattern = /(日本語配列|英語配列|JIS配列|US配列|日本語レイアウト)/
    match = text.match(layout_pattern)
    return match[0].gsub(/(日本語レイアウト|日本語配列)/, "JIS配列").gsub(/(英語配列|英語レイアウト)/, "US配列") if match
    nil
  end

  # タグの作成と関連付けのメソッド
  def create_and_assign_tags(keyboard_info, keyboard)
    tags_to_create = [
      convert_os_to_string(keyboard_info[:os]),
      keyboard_info[:size],
      keyboard_info[:switch],
      keyboard_info[:layout]
    ].compact

    # キーボードに既に関連付けられているタグを取得
    existing_tags = keyboard.tags.to_a

    tags_to_create.each do |tag_name|
      create_and_assign_tag(tag_name, keyboard, existing_tags)
    end
  end

  # 配列を文字列に変換する ※ここで結合しないと先頭しか保存されない
  def convert_os_to_string(os)
    if os.is_a?(Array)
      return os.join(' ')
    end
    os
  end

  def create_and_assign_tag(tag_names, keyboard, existing_tags)
    if tag_names
      tag_names.split(' ').each do |tag_name|
        tag = existing_tags.find { |t| t.name == tag_name }

        if tag.nil?
          tag = Tag.find_or_create_by(name: tag_name)
          keyboard.tags << tag
          existing_tags << tag
        end
      end
    end
  end
end
