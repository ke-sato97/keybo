require 'rails_helper'

RSpec.describe 'Diagnoses' do
  describe 'diagnoses' do
    let(:user) { create(:user) } # 必要に応じて user の作成も追加
    # let(:diagnosis) { create(:diagnosis, user: user, keyboard: keyboard) }

    describe '診断フォーム成功' do
      let(:keyboard) { create(:keyboard) }

      before do
        login(user)
      end

      context 'フォームの入力が正常' do
        it '1.必須項目のみ入力' do
          # ラジオボタン
          visit new_diagnosis_path
          choose '0~5000円' # ラジオボタンを選択する
          expect(page).to have_checked_field '0~5000円' # 選択されたことを確認する

          click_button '診断する'
          puts keyboard.inspect
          expect(page).to have_current_path diagnosis_path(keyboard), ignore_query: true
        end
      end
    end

    describe '診断フォーム失敗' do
      before { login(user) }

      context 'フォーム未記入' do
        it '診断失敗(１を選択していない)' do
          visit new_diagnosis_path

          # ラジオボタン
          expect(page).to have_checked_field '選択しない' # デフォルトで選択しないがチェックされていることを検証
          choose 'Mac'
          expect(page).to have_checked_field 'Mac' # Macがチェックされていることを検証

          click_button '診断する'
          expect(page).to have_current_path new_diagnosis_path, ignore_query: true
          expect(page).to have_content '質問１は必須項目です'
        end

        it '診断失敗(診断結果が見つからない)' do
          visit new_diagnosis_path

          # ラジオボタン
          choose '10001~15000円' # ラジオボタンを選択する
          expect(page).to have_checked_field '10001~15000円' # 選択されたことを確認する
          expect(page).to have_checked_field '選択しない' # デフォルトで選択しないがチェックされていることを検証
          choose 'US配列'
          expect(page).to have_checked_field 'US配列'

          click_button '診断する'
          expect(page).to have_current_path new_diagnosis_path, ignore_query: true
          expect(page).to have_content '選択された条件に合うものは見つかりませんでした'
        end
      end
    end
  end
end
