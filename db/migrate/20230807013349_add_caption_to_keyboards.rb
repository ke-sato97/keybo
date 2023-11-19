# frozen_string_literal: true

class AddCaptionToKeyboards < ActiveRecord::Migration[7.0]
  def change
    add_column :keyboards, :caption, :text
  end
end
