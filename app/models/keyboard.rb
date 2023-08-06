class Keyboard < ApplicationRecord
  validates :model, presence: true, uniqueness: true
end
