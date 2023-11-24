require 'rails_helper'

RSpec.describe 'Diagnoses', type: :system do
  describe 'diagnoses' do
    let(:user) { create(:user) } # 必要に応じて user の作成も追加
    let(:keyboard) { create(:keyboard) }
    # let(:selected_keyboard) { create(:selected_keyboard) }

    describe '診断フォーム' do
      before { login(user) }

      context 'フォームの入力が正常' do
        it '1.必須項目のみ入力' do
          visit new_diagnosis_path

          # ラジオボタン
          choose '10001~15000円' # ラジオボタンを選択する
          expect(page).to have_checked_field '10001~15000円' # 選択されたことを確認する

          click_button '診断する'
          expect(current_path).to eq diagnosis_path(keyboard)
        end

        it '1.必須項目と任意項目入力' do
          visit new_diagnosis_path
          choose '0~5000円'
          click_button '診断する'
        end
      end

      context 'フォーム未記入' do
        it '2.診断失敗' do
          visit new_diagnosis_path

          # ラジオボタン
          expect(page).to have_checked_field with: '選択しない', visible: false # デフォルトで選択しないがチェックされていることを検証
          find('label[for=Mac]').click # Macをクリック（こちらも先程のテストから変更してます）
          expect(page).to have_checked_field with: 'Mac', visible: false # Macがチェックされていることを検証

          click_button '診断する'
          expect(current_path).to eq new_diagnosis_path
        end
      end
    end
  end
end
