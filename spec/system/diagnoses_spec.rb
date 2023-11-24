require 'rails_helper'

RSpec.describe 'Diagnoses', type: :system do
  describe 'diagnoses' do
    let(:user) { create(:user) } # 必要に応じて user の作成も追加
    let(:keyboard) { create(:keyboard) }

    describe '診断フォーム' do
      before { login(user) }
      let(:selected_keyboard) { create(:selected_keyboard) }

      context 'フォームの入力が正常' do
        it '1.必須項目のみ入力' do
          visit new_diagnosis_path

          # ラジオボタン
          choose '0~5000円' # ラジオボタンを選択する
          expect(page).to have_checked_field '0~5000円' # 選択されたことを確認する

          click_button '診断する'
          expect(current_path).to eq diagnosis_path(selected_keyboard)
        end

        it '1.必須項目と任意項目入力' do
          visit new_diagnosis_path
          choose '0~5000円'
          click_button '診断する'
        end
      end

      context 'フォーム未記入' do
        it '2.診断失敗' do
        end
      end
    end
  end
end
