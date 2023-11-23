require 'rails_helper'

RSpec.describe 'Users', type: :system do
  # spec/factories/*.rb で作成されたデータ
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'User CRUD' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        context 'フォームの入力が正常' do
          it 'ユーザーの新規作成が成功' do
            # ユーザー新規登録画面へ遷移
            visit new_user_path
            # Emailテキストフィールドにtest@example.comと入力
            fill_in 'Name', with: 'name'
            # Emailテキストフィールドにtest@example.comと入力
            fill_in 'Email', with: 'test@example.com'
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'Password', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'Password confirmation', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button '登録'
            # new_user_pathへ遷移することを期待する
            expect(current_path).to eq root_path
          end
        end

        context 'メールアドレス未記入' do
          it 'ユーザーの新規作成が失敗' do
            # ユーザー新規登録画面へ遷移
            visit new_user_path
            # Emailテキストフィールドにtest@example.comと入力
            fill_in 'Name', with: 'name'
            # Emailテキストフィールドにtest@example.comと入力
            fill_in 'Email', with: nil
            # Passwordテキストフィールドにpasswordと入力
            fill_in 'Password', with: 'password'
            # Password confirmationテキストフィールドにpasswordと入力
            fill_in 'Password confirmation', with: 'password'
            # SignUpと記述のあるsubmitをクリックする
            click_button '登録'
            # new_user_pathへ遷移することを期待する
            expect(current_path).to eq users_path
          end
        end
      end
    end

    describe 'ログイン後' do
      before { login(user) }
        describe 'ユーザー編集' do
          context 'フォームの入力が正常' do
            it 'フォームの入力が正常' do
              visit login_path
              fill_in 'Email', with: user.email
              fill_in 'Password', with: 'password'
              click_button 'ログイン'
              expect(current_path).to eq root_path
            end
          end

          context 'メールアドレス未記入' do
            it 'フォームの入力が正常' do
              visit login_path
              fill_in 'Email', with: nil
              fill_in 'Password', with: 'password'
              click_button 'ログイン'
              expect(current_path).to eq login_path
            end
          end
        end
      end
    end
  end
