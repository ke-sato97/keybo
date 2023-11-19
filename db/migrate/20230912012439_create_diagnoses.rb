# frozen_string_literal: true

class CreateDiagnoses < ActiveRecord::Migration[7.0]
  def change
    create_table :diagnoses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :keyboard, null: false, foreign_key: true

      t.timestamps
    end
  end
end
