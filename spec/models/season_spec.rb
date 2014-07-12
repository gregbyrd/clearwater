require 'rails_helper'

describe Season, :type => :model do
  describe 'validations' do
    it { should validate_numericality_of(:start_month).
      is_greater_than(0).is_less_than(13) }
    it { should validate_numericality_of(:end_month).
      is_greater_than(0).is_less_than(13) }
    it { should validate_numericality_of(:year).is_greater_than(0) }
    it { should validate_numericality_of(:slot_limit).is_greater_than(0) }
    it { should have_many(:fish_dates) }
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
