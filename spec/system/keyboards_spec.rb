require 'rails_helper'

RSpec.describe 'Keyboards' do
  let(:user) { create(:user) }
  let(:keybaord) { create(:keybaord) }

  describe 'keyboards' do
    describe '失敗' do
      describe '一覧画面' do
        before { login(user) }

        it '詳細画面に移動' do
          fill_in 'キーボードを検索する', with: 'hhkb'
          click_button have_css('.fa-')
          expect(page).to have_current_path keybaords_path, ignore_query: true
        end
      end

      describe '一覧画面' do
        before { login(user) }

        it '詳細画面に移動' do
          visit keyboards_path
          expect(page).to have_current_path root_path, ignore_query: true
        end
      end
    end
  end
end
