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

  describe 'dates' do
    it 'should convert start month to date' do
      s = Season.new(:year => 2013,
                     :start_month => 10,
                     :end_month => 12)
      sd = s.start_date
      expect(sd.year).to eq(2013)
      expect(sd.month).to eq(10)
      expect(sd.day).to eq(1)
    end
    it 'should convert end month to date' do
      s = Season.new(:year => 2013,
                     :start_month => 10,
                     :end_month => 12)
      ed = s.end_date
      expect(ed.year).to eq(2013)
      expect(ed.month).to eq(12)
      expect(ed.day).to eq(31)
    end
    it 'should deal with end date in next year' do
      s = Season.new(:year => 2013,
                     :start_month => 10,
                     :end_month => 4)
      ed = s.end_date
      expect(ed.year).to eq(2014)
      expect(ed.month).to eq(4)
      expect(ed.day).to eq(30)
    end
  end
end
