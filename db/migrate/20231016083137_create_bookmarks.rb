class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :keyboard, null: false, foreign_key: true

      t.timestamps
    end
    # bookmarksにおいてuser_idとpost_idの組み合わせを一意性あるものにする
    add_index :bookmarks, %i[user_id keyboard_id], unique: true
  end
end
