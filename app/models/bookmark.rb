class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :keyboard

  # 重複したお気に入りができない。これを書かないと他のkeyboardにお気に入りができない
  validates :user_id, uniqueness: { scope: :keyboard_id }
end
