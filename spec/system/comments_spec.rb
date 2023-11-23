require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'comments' do
    describe 'コメントフォーム' do

     context 'フォームの入力が正常' do
       it '1.コメント成功' do
        visit keyboard_path(keyboard)
       end
     end

     context 'フォーム未記入' do
       it '2.コメント失敗'
     end
   end
  end
end
