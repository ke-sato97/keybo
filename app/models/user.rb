class User < ApplicationRecord
  authenticates_with_sorcery!

  enum role: { general: 0, admin: 1, guest: 2 }

  has_one_attached :image
  has_many :diagnoses, dependent: :destroy
  has_many :keyboards, dependent: :destroy, through: :diagnoses
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_keyboards, through: :bookmarks, source: :keyboard

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  validate :file_type
  validate :file_size

  # 引数で渡したkeyboardレコードを中間テーブルに自動で保存している。<<を使うことでsaveメソッドも自動で行う。
  def bookmark(keyboard)
    bookmark_keyboards << keyboard
  end

  # 引数で渡したkeyboardを削除する
  def unbookmark(keyboard)
    bookmark_keyboards.destroy(keyboard)
  end

  # すでにお気に入りしているかどうか判断する
  def bookmark?(keyboard)
    bookmark_keyboards.include?(keyboard)
  end

  def file_type
    if !image.blob.content_type.in?(%('image/jpeg image/png'))
      errors.add(:images, 'は JPEG 形式または PNG 形式のみ選択してください')
    end
  end

  def file_size
    if image.blob.byte_size > 5.megabytes
      errors.add(:images, 'は 5MB 以下のファイルを選択してください')
    end
  end
end
