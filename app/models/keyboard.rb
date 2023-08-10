class Keyboard < ApplicationRecord
  validates :model, presence: true, uniqueness: true

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
end
