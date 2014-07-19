Given /the following users exist/ do |user_table|
  user_table.hashes.each do |user|
    if user[:season]
      season = Season.find_by_year(user[:season])
    else
      season = Season.find(Properties.instance.current_season_id)
    end
    FactoryGirl.create(:user,
                       email: user[:email],
                       password: user[:password],
                       password_confirmation: user[:password],
                       admin: user[:admin],
                       season: season, 
                       purchased: user[:slots] || 8)
  end
end

Given /the following seasons exist/ do |seasons|
  seasons.hashes.each do |s|
    FactoryGirl.create(:season, year: s[:year], slot_limit: s[:slots])
  end
end

Given /the following dates exist/ do |dates|
  dates.hashes.each do |d|
    season = Season.find_by_year(d[:season])
    FactoryGirl.create(:fish_date,
                       day: Date.parse(d[:date]),
                       season: season,
                       slot_limit: season.slot_limit)
  end
end

Given /(.+) is logged in with password "(.+)"/ do |email, passwd|
  visit path_to('the login page')
  fill_in('email', :with => email)
  fill_in('password', :with=> passwd)
  click_button('Log in')
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

Given /test user is (.+)/ do |email|
  @test_user = User.find_by_email(email)
end

When /I follow the "(.+)" link for user (.+)/ do |link, email|
  user = User.find_by_email(email)
  linkid = "#{link.downcase}_#{user.id}"
  click_link(linkid)
end

When /I follow "(.+)"/ do |link|
  click_link(link)
end

When /I choose the date "(.+)"/ do |daystr|
  d = Date.parse(daystr)
  fd = FishDate.find_by_day(d)
  radio_id = "fish_date_#{fd.id}"
  choose(radio_id)
end

Then /I find (.+) in Users/ do |email|
  expect(User.find_by_email(email)).to_not eq(nil)
end

Then /I do not find (.+) in Users/ do |email|
  expect(User.find_by_email(email)).to eq(nil)
end

Then /(.+) is not admin/ do |email|
  expect(User.find_by_email(email).admin?).to eq(false)
end

Then /(.+) is admin/ do |email|
  expect(User.find_by_email(email).admin?).to eq(true)
end

Then /user password should be "(.+)"/ do |passwd|
  expect(@test_user.authenticate(passwd)).to eq(@test_user)
end

Then /test user (.+) should be "(.+)"/ do |method, value|
  expect(@test_user.send(method)).to eq(value)
end

Then /test user (.+) should be (\d+)/ do |method, value|
  expect(@test_user.send(method)).to eq(value.to_i)
end

Then /I can find "(.+)" field/ do |field|
  expect(find_field(field)).to_not eq(nil)
end

Then /I cannot find "(.+)" field/ do |field|
  expect { find_field(field) }.to raise_error(Capybara::ElementNotFound)
end



