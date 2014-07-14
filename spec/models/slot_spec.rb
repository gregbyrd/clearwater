require 'rails_helper'

describe Slot, :type => :model do
  describe 'validations' do
    it { should validate_presence_of :label }
  end
end
