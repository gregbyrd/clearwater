
describe SeasonPolicy do
  subject(:policy) { SeasonPolicy.new(user, season) }

  let (:season) { FactoryGirl.build(:season) }

  context 'admin user' do
    let (:user) { FactoryGirl.build(:user, :admin) }

    it { should auth_permit(:create) }
    it { should auth_permit(:update) }
    it { should auth_permit(:edit) }
    it { should auth_permit(:show) }
    it { should auth_permit(:index) }

  end

  context 'non-admin user' do
    let (:user) { FactoryGirl.build(:user) }

    it { should_not auth_permit(:create) }
    it { should_not auth_permit(:update) }
    it { should_not auth_permit(:edit) }
    it { should_not auth_permit(:show) }
    it { should_not auth_permit(:index) }
  end
end

