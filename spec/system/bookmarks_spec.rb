require 'rails_helper'

RSpec.describe 'Bookmarks', type: :system do
  let(:user) { create(:user) }
  let(:keyboard) { create(:keyboard) }
  let(:bookmark) { create(:bookmark, user: user, keyboard: keyboard) }

  describe 'bookmarks' do
    before { login(user) }
    describe 'ブックマーク前' do
      it 'ブックマークの追加' do
        visit keyboard_path(keyboard)

        # ブックマークがない場合
        expect(page).to have_selector('.fa-heart') # ブックマークが解除されていることを確認

        # クリック
        click_link "bookmark-#{keyboard.id}"
        expect(page).to have_content 'お気に入り登録しました'
        expect(page).to have_selector('.fa-heart') # ブックマークが追加されていることを確認
      end
    end

    describe 'ブックマーク後' do
      before do
        user.bookmark(keyboard) # ブックマークを追加
      end

      it 'ブックマークの追加' do
        visit keyboard_path(keyboard)

        # ブックマークがない場合
        expect(page).to have_selector('.fa-heart') # ブックマークが解除されていることを確認

        # ブックマークを解除
        click_link "unbookmark-#{keyboard.id}"
        expect(page).to have_content 'お気に入りを解除しました'
        expect(page).to have_selector('.fa-heart') # ブックマークが解除されていることを確認
      end
    end
  end
end
