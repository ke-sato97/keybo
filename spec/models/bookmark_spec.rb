require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'モデルのテスト' do
    it "有効なbookmarkの場合は保存されるか" do
      expect(build(:bookmark)).to be_valid
    end
  end
end
