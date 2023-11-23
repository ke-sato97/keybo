require 'rails_helper'

RSpec.describe 'Contacts', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'contacts' do
    describe 'お問い合わせフォーム' do
      before { login(user) }

      context 'フォームの入力が正常' do
        it '1.コメント成功' do
        end
      end

      context 'フォーム未記入' do
        it '2.コメント失敗' do
        end
      end
    end
  end
end
