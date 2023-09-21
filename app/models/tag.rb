class Tag < ApplicationRecord
  has_many :keyboard_tags, dependent: :destroy
  has_many :keyboards, dependent: :destroy, through: :keyboard_tags

  validates :name, uniqueness: true
end
