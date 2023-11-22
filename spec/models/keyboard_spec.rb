require 'rails_helper'

RSpec.describe Keyboard, type: :model do
  describe 'モデルのテスト' do
    it "有効なkeyboard場合は保存されるか" do
      expect(build(:keyboard)).to be_valid
    end

    context "バリデーションチェック" do
      it "nameが空白の場合にエラーメッセージが返ってくるか" do
        # passwordのバリデーションチェック
        keyboard = build(:keyboard, name: nil)
        keyboard.valid?
        expect(keyboard.errors[:name]).to include("を入力してください")
      end
    end
  end
end
