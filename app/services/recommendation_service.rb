# services/recommendation_service.rb

class RecommendationService
  def self.item_based_recommendation(keyboard_id)
    target_keyboard = Keyboard.find(keyboard_id)
    all_keyboards = Keyboard.where.not(id: keyboard_id)

    # タグの類似度を計算し、類似度が高い順にソート
    similar_keyboards = all_keyboards.sort_by do |other_keyboard|
      calculate_jaccard_similarity(target_keyboard.tags, other_keyboard.tags)
    end.reverse

    # レコメンドされるキーボードのIDの配列を返す
    similar_keyboards[1..5]
  end

  private

  def self.calculate_jaccard_similarity(tags1, tags2)
    intersection = (tags1 & tags2).count.to_f
    union = (tags1 | tags2).count.to_f

    # Jaccard 係数を計算して返す
    union.zero? ? 0.0 : (intersection / union)
  end
end
