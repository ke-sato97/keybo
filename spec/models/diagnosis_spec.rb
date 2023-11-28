require 'rails_helper'

RSpec.describe Diagnosis do
  describe 'モデルのテスト' do
    it '有効なdiagnosisの場合は保存されるか' do
      expect(build(:diagnosis)).to be_valid
    end
  end
end
