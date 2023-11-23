require 'rails_helper'

RSpec.describe 'Users', type: :system do
  # spec/factories/*.rb で作成されたデータ
  let(:user) { create(:user) }
  let(:keyboard) { create(:keyboard) }

  describe 'comments' do
    describe 'コメントフォーム' do

     context 'フォームの入力が正常' do
       before 'ログイン処理' do
         visit login_path
         fill_in 'Email', with: user.email
         fill_in 'Password', with: user.password
         click_button 'ログイン'
         expect(current_path).to eq login_path
       end

       it 'コメント成功' do
         visit keyboard_path(keyboard)
         fill_in 'コメントフォーム', with: 'test'
         # click_button '送信'
       end
     end

     context 'フォーム未記入' do
       it 'コメント失敗'
     end
   end
  end
end
