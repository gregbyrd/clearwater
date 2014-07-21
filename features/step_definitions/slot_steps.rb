Given /the following reservations exist/ do |slot_table|
  slot_table.hashes.each do |slot|
    fd = FishDate.find_by_day(Date.parse(slot[:date]))
    user = User.find_by_email(slot[:user])
    label = slot[:guest] == '' ? 'self' : slot[:guest]
    FactoryGirl.create(:slot,
                       fish_date: fd,
                       user: user,
                       label: label)
  end
end

When /I choose user (.+)/ do |email|
  u = User.find_by_email(email)
  radio_id = "user_#{u.id}"
  choose(radio_id)
end
