class CreateKeyboards < ActiveRecord::Migration[7.0]
  def change
    create_table :keyboards do |t|
      t.string :model
      t.string :brand
      t.string :image
      t.string :os
      t.integer :price
      t.string :layout
      t.string :size
      t.string :switch

      t.timestamps
    end
  end
end
