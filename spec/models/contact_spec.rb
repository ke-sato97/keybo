require 'rails_helper'

RSpec.describe Contact do
  describe 'モデルのテスト' do
    it '有効なcontactの場合は保存されるか' do
      # FactoryBotで作ったデータが有効であるか確認しています
      expect(build(:contact)).to be_valid
    end

    context 'バリデーションチェック' do
      it 'nameが空白の場合にエラーメッセージが返ってくるか' do
        # passwordのバリデーションチェック
        contact = build(:contact, name: nil)
        contact.valid?
        expect(contact.errors[:name]).to include('を入力してください')
      end

      it 'emailが空白の場合にエラーメッセージが返ってくるか' do
        # passwordのバリデーションチェック
        contact = build(:contact, email: nil)
        contact.valid?
        expect(contact.errors[:email]).to include('を入力してください')
      end

      it 'subjectが空白の場合にエラーメッセージが返ってくるか' do
        # passwordのバリデーションチェック
        contact = build(:contact, subject: nil)
        contact.valid?
        expect(contact.errors[:subject]).to include('を入力してください')
      end

      it 'messageが空白の場合にエラーメッセージが返ってくるか' do
        # passwordのバリデーションチェック
        contact = build(:contact, message: nil)
        contact.valid?
        expect(contact.errors[:message]).to include('を入力してください')
      end
    end
  end
end
