# frozen_string_literal: true

class KeyboardTag < ApplicationRecord
  belongs_to :keyboard
  belongs_to :tag
end
