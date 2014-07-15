Given /the following users exist/ do |user_table|
  user_table.hashes.each do |user|
    User.create!(email: user[:email],
                 password: user[:password],
                 password_confirmation: user[:password],
                 admin: user[:admin])
  end
end

Given /I am logged in as admin/ do
  admin = FactoryGirl.create(:user, admin: true)
  visit path_to("the login page")
  fill_in('email', :with => admin.email)
  fill_in('password', :with=> 'abc')
  click_button('Log in')
end

