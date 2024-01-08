# app/services/recommendation_service.rb

class RecommendationService
  def recommend_keyboards(keyboard)
    # ユーザーが診断したキーボードとのCosine Similarityを計算し、類似度が高い順にソートする
    similar_keyboards = Keyboard.all.sort_by do |other_keyboard|
      cosine_similarity(keyboard, other_keyboard)
    end.reverse

    # 推薦するキーボードを返す
    similar_keyboards[1..5] # 類似度が高い上位5つを返す（自分自身を含めない）
  end

  private

  def cosine_similarity(keyboard1, keyboard2)
    # 特徴ベクトルの作成
    vector1 = keyboard_vector(keyboard1)
    vector2 = keyboard_vector(keyboard2)

    # Cosine Similarityの計算
    dot_product = vector1.zip(vector2).sum { |a, b| a * b }
    magnitude1 = Math.sqrt(vector1.sum { |a| a**2 })
    magnitude2 = Math.sqrt(vector2.sum { |a| a**2 })

    dot_product / (magnitude1 * magnitude2)
  end

  def keyboard_vector(keyboard)
    # 特徴ベクトルの初期化
    vector = []

    # layoutの数値化
    vector << layout_to_number(keyboard.layout)

    # sizeの数値化
    vector << size_to_number(keyboard.size)

    # switchの数値化
    vector << switch_to_number(keyboard.switch)

    vector
  end

  def layout_to_number(layout)
    # layoutに対して数値を割り当てるロジックを実装
    # 例えば、JIS配列を1、US配列を2とするなど
    case layout
    when 'JIS配列'
      1
    when 'US配列'
      2
    else
      0
    end
  end

  def size_to_number(size)
    # sizeに対して数値を割り当てるロジックを実装
    # 例えば、フルサイズを1、テンキーレスを2とするなど
    case size
    when 'フルサイズ'
      1
    when 'テンキーレス'
      2
    else
      0
    end
  end

  def switch_to_number(switch)
    # switchに対して数値を割り当てるロジックを実装
    # 例えば、メカニカルを1、メンブレンを2とするなど
    case switch
    when 'メカニカル'
      1
    when 'メンブレン'
      2
    else
      0
    end
  end
end
