# frozen_string_literal: true

class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :subject, presence: true, length: { maximum: 255 }
  validates :message, presence: true, length: { maximum: 4000 }
end
