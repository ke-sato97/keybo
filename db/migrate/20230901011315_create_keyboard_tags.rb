class CreateKeyboardTags < ActiveRecord::Migration[7.0]
  def change
    create_table :keyboard_tags do |t|
      t.references :keyboard, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
