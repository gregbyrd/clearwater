Given /the following users exist/ do |user_table|
  user_table.hashes.each do |user|
    User.create!(email: user[:email],
                 password: user[:password],
                 password_confirmation: user[:password],
                 admin: user[:admin])
  end
end
