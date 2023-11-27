require 'rails_helper'

RSpec.describe 'Profile', type: :system do
  let(:user) { create(:user) }

  describe 'profile' do
    describe 'プロフィール画面が正常' do
      before { login(user) }

      context 'フォームの入力が正常' do
        it 'プロフィール確認画面' do
          visit new_contact_path
          fill_in '名前', with: 'test'
          fill_in 'メールアドレス', with: 'test@email.com'
          fill_in '件名', with: 'test'
          fill_in 'メッセージ', with: 'test'
          click_button '入力内容確認'

          # ここで確認画面に遷移している
          expect(current_path).to eq contacts_confirm_path

          # フォームに入力されたデータが持ち越されているか
          expect(page).to have_content 'test'
          expect(page).to have_content 'test@email.com'
          expect(page).to have_content 'test'
          expect(page).to have_content 'test'

          # フォームの送信
          click_button '送信'
          expect(current_path).to eq contacts_done_path
        end
      end

      context 'フォーム未記入' do
        it '2.お問い合わせ失敗' do
          visit new_contact_path
          fill_in '名前', with: nil
          fill_in 'メールアドレス', with: 'test@email.com'
          fill_in '件名', with: 'test'
          fill_in 'メッセージ', with: 'test'
          click_button '入力内容確認'
          expect(current_path).to eq contacts_confirm_path
          expect(page).to have_content "を入力してください"
        end
      end
    end
  end
end
