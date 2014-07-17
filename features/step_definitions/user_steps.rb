Given /the following users exist/ do |user_table|
  user_table.hashes.each do |user|
    FactoryGirl.create(:user,
                       email: user[:email],
                       password: user[:password],
                       password_confirmation: user[:password],
                       admin: user[:admin],
                       season: user[:season] || 
                               Season.find(Properties.instance.current_season_id))
  end
end

Given /I am logged in as admin/ do
  admin = FactoryGirl.create(:user, admin: true)
  visit path_to("the login page")
  fill_in('email', :with => admin.email)
  fill_in('password', :with=> 'abc')
  click_button('Log in')
end

Given /I am logged in as user/ do
  step 'a current season'
  admin = FactoryGirl.create(:user, admin: false,
                             season: Season.find(Properties.instance.current_season_id))
  visit path_to("the login page")
  fill_in('email', :with => admin.email)
  fill_in('password', :with=> 'abc')
  click_button('Log in')
end

Given /a current season/ do
  s = FactoryGirl.create(:season)
  prop = FactoryGirl.create(:property)
  prop.current_season_id = s.id
  prop.save
end

Then /I find (.+) in Users/ do |email|
  expect(User.find_by_email(email)).to_not eq(nil)
end

Then /(.+) is not admin/ do |email|
  expect(User.find_by_email(email).admin?).to eq(false)
end

Then /(.+) is admin/ do |email|
  expect(User.find_by_email(email).admin?).to eq(true)
end




