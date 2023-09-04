class Keyboard < ApplicationRecord
  has_many :keyboard_tags, dependent: :destroy
  has_many :tags, dependent: :destroy, through: :keyboard_tags

  validates :model, presence: true, uniqueness: true
  validates :brand, presence: true
  validates :os, presence: true
  validates :layout, presence: true
  validates :size, presence: true
  validates :switch, presence: true
  validates :caption, presence: true
end

