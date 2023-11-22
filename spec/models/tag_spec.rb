require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'モデルのテスト' do
    it "有効なuserの場合は保存されるか" do
      # FactoryBotで作ったデータが有効であるか確認しています
      expect(build(:tag)).to be_valid
    end
  end
end
