# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer, default: 0, null: false
  end
end
