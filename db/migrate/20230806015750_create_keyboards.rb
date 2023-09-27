class CreateKeyboards < ActiveRecord::Migration[7.0]
  def change
    create_table :keyboards do |t|
      t.string :name
      t.string :brand
      t.string :medium_image_urls, array: true, default: []
      t.string :os, array: true, default: []
      t.integer :price
      t.string :layout
      t.string :size
      t.string :switch
      t.string :url

      t.timestamps
    end
  end
end
