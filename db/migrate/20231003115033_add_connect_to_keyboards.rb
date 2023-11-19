# frozen_string_literal: true

class AddConnectToKeyboards < ActiveRecord::Migration[7.0]
  def change
    add_column :keyboards, :connect, :string, array: true, default: []
  end
end
