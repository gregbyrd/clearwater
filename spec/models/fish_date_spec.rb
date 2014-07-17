require 'rails_helper'

describe FishDate, :type => :model do
  describe 'validations' do
    it 'should validate day as a date' do
      fd = FishDate.new(:day => 10)
      expect(fd.valid?).to eq(false)
    end
    it { should belong_to(:season) }
    it { should validate_numericality_of(:slot_limit) }
  end
end
