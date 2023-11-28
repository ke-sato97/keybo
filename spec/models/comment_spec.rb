require 'rails_helper'

RSpec.describe Comment do
  describe 'モデルのテスト' do
    it '有効なdiagnosisの場合は保存されるか' do
      expect(build(:comment)).to be_valid
    end

    context 'バリデーションチェック' do
      it 'bodyが空白の場合にエラーメッセージが返ってくるか' do
        # bodyのバリデーションチェック
        comment = build(:comment, body: nil)
        comment.valid?
        expect(comment.errors[:body]).to include('を入力してください')
      end

      it 'subjectが255文字を超える場合にエラーメッセージが返ってくるか' do
        contact = build(:contact, subject: 'a' * 256)
        contact.valid?
        expect(contact.errors[:subject]).to include('は255文字以内で入力してください')
      end

      it 'messageが65_536文字を超える場合にエラーメッセージが返ってくるか' do
        contact = build(:contact, message: 'a' * 65_536)
        contact.valid?
        expect(contact.errors[:message]).to include('は65535文字以内で入力してください')
      end
    end
  end
end
