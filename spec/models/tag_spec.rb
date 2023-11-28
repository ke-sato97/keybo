require 'rails_helper'

RSpec.describe Tag do
  describe 'モデルのテスト' do
    it '有効なtagの場合は保存されるか' do
      # FactoryBotで作ったデータが有効であるか確認しています
      expect(build(:tag)).to be_valid
    end

    context 'バリデーションチェック' do
      it 'nameが重複する場合にエラーメッセージが返ってくるか' do
        # 重複するメールアドレスを持つユーザーオブジェクトを作成
        create(:tag, name: 'name')
        tag = build(:tag, name: 'name')
        tag.valid?
        expect(tag.errors[:name]).to include('はすでに存在します')
      end
    end
  end
end
