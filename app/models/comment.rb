# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :keyboard

  validates :body, presence: true, length: { maximum: 65_535 }
end
