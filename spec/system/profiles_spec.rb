require 'rails_helper'

RSpec.describe 'Profile', type: :system do
  let(:user) { create(:user) }

  describe 'profile' do
    describe 'プロフィール画面が正常' do
      before { login(user) }

      context 'フォームの入力が正常' do
        it 'プロフィール確認画面' do
          visit profile_path
          # フォームに入力されたデータが持ち越されているか
          expect(page).to have_content user.name
          expect(page).to have_content user.email
          click_link 'プロフィールを変更'
          expect(current_path).to eq edit_profile_path

          expect(page).to have_content user.name
          expect(page).to have_content user.email
        end
        it 'プロフィール編集画面' do
          visit edit_profile_path
          # フォームに入力されたデータが持ち越されているか
          fill_in '名前', with: 'test'
          fill_in 'メールアドレス', with: 'test@email.com'
          click_button '変更'
          expect(page).to have_content "プロフィールを更新しました"
        end
      end

      context 'フォーム未記入' do
        it '編集失敗' do
          visit edit_profile_path
          fill_in '名前', with: nil
          fill_in 'メールアドレス', with: 'test@email.com'
          click_button '変更'
          expect(page).to have_content "プロフィールを更新できませんでした"
        end
      end
    end
  end
end
