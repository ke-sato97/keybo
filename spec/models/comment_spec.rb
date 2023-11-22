require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'モデルのテスト' do
    it "有効なdiagnosisの場合は保存されるか" do
      expect(build(:comment)).to be_valid
    end

    context "バリデーションチェック" do
      it "bodyが空白の場合にエラーメッセージが返ってくるか" do
        # bodyのバリデーションチェック
        comment = build(:comment, body: nil)
        comment.valid?
        expect(comment.errors[:body]).to include("を入力してください")
      end
    end
  end
end
