require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  # spec/factories/*.rb で作成されたデータ
  let(:keyboard) { create(:keyboard) }

  describe 'comments' do
    let(:user) { create(:user) } # 必要に応じて user の作成も追加

    describe 'コメントフォーム' do
      before { login(user) }

      context 'フォームの入力が正常' do
        it 'コメント成功' do
          visit keyboard_path(keyboard)
          fill_in 'コメントフォーム', with: 'test'
          click_button '送信'
          # expect(page).to have_content "コメントを投稿しました。"
        end
      end

      context 'フォーム未記入' do
        it 'コメント失敗' do
          visit keyboard_path(keyboard)
          fill_in 'コメントフォーム', with: nil
          click_button '送信'
          # expect(page).to have_content "コメントできませんでした。"
        end
      end
    end
  end
end
