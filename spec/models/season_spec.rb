require 'rails_helper'

describe Season, :type => :model do
  describe 'validations' do
    it 'should validate start month' do
      s = Season.new(:start_month => 13)
      expect(s.valid?).to eq(false)
    end
    it 'should validate end month' do
      s = Season.new(:end_month => 13)
      expect(s.valid?).to eq(false)
    end
    it 'should validate year' do
      s = Season.new(:year => nil)
      expect(s.valid?).to eq(false)
    end
    it 'should validate slot limit' do
      s = Season.new(:slot_limit => nil)
      expect(s.valid?).to eq(false)
    end
  end
end
