require 'rails_helper'

RSpec.describe 'Diagnoses', type: :system do
  let(:keyboard) { create(:keyboard) }

  describe 'diagnoses' do
    let(:user) { create(:user) } # 必要に応じて user の作成も追加

    describe '診断フォーム' do
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
