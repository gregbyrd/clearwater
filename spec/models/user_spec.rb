require 'rails_helper'

describe User, :type => :model do
  describe 'validations' do
    it { should have_many :slots } 
    it { should validate_presence_of :password_digest }
    it { should validate_presence_of :email }
    it { should allow_value("abc@abc.com").for(:email) }
    it { should_not allow_value("blah").for(:email) }
    it { should serialize :guests }
    it { should allow_value(nil).for :guests }
  end
end
