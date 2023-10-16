class Keyboard < ApplicationRecord
  has_many :diagnoses, dependent: :destroy
  has_many :users, dependent: :destroy, through: :diagnoses
  has_many :keyboard_tags, dependent: :destroy
  has_many :tags, dependent: :destroy, through: :keyboard_tags
  has_many :bookmarks, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true
  validates :os, presence: true
  validates :caption, presence: true
end
