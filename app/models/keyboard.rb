class Keyboard < ApplicationRecord
  has_many :keyboard_tags, dependent: :destroy
  has_many :tags, dependent: :destroy, through: :keyboard_tags

  validates :name, presence: true, uniqueness: true
  validates :brand, presence: true
  validates :os, presence: true
  validates :caption, presence: true
end

