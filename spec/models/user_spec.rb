require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'モデルのテスト' do
    it "有効なuserの場合は保存されるか" do
      # FactoryBotで作ったデータが有効であるか確認しています
      expect(build(:user)).to be_valid
    end

    context "バリデーションチェック" do
      it "passwordが空白の場合にエラーメッセージが返ってくるか" do
        # passwordのバリデーションチェック
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("は3文字以上で入力してください")
      end

      it "無効な場合はエラーメッセージが返ってくるか" do
        # FactoryBotで作ったデータが有効であるか確認しています
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("は3文字以上で入力してください")
      end
    end
  end
end
