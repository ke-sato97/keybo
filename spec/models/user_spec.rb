require 'rails_helper'

RSpec.describe User do
  describe 'モデルのテスト' do
    it '有効なuserの場合は保存されるか' do
      # FactoryBotで作ったデータが有効であるか確認しています
      expect(build(:user)).to be_valid
    end

    context 'バリデーションチェック' do
      it 'nameが空白の場合にエラーメッセージが返ってくるか' do
        # nameのバリデーションチェック
        user = build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include('を入力してください')
      end

      it 'emailが空白の場合にエラーメッセージが返ってくるか' do
        # emailのバリデーションチェック
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include('を入力してください')
      end

      it '無効な場合はエラーメッセージが返ってくるか' do
        # FactoryBotで作ったデータが有効であるか確認しています
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include('は3文字以上で入力してください')
      end

      it 'emailが重複する場合にエラーメッセージが返ってくるか' do
        # 重複するメールアドレスを持つユーザーオブジェクトを作成
        create(:user, email: 'test@example.com')
        user = build(:user, email: 'test@example.com')
        user.valid?
        expect(user.errors[:email]).to include('はすでに存在します')
      end
    end
  end
end
