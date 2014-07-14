require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'validations' do
    it { should validate_presence_of :password_digest }
    it { should validate_presence_of :admin }
    it { should validate_presence_of :email }
    it { should allow_value("abc@abc.com").for(:email) }
    it { should_not allow_value("blah").for(:email) }
  end
end
