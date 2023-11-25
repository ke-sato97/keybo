require 'rails_helper'

RSpec.describe 'Bookmarks', type: :system do
  let(:user) { create(:user) }
  let(:keyboard) { create(:keyboard) }
  let(:bookmark) { create(:bookmark) }

  describe 'bookmarks' do
    describe 'ブックマーク成功' do
      before { login(user) }

      context 'ブックマークが正常' do
        it 'ブックマーク成功' do
          visit keyboard_path(keyboard)
          find('div.class fa-heart').click
          click_button '送信'
          expect(page).to have_content "お気に入り登録しました"
        end

        it 'ブックマーク解除成功' do
          visit keyboard_path(keyboard)
          find('div.class fa-heart').click
          click_button '送信'
          expect(page).to have_content "お気に入りを解除しました"
        end
      end
    end
  end
end
