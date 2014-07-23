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

When /I choose button for "(.+)"/ do |label|
  choose(label)
end

When /I choose admin/ do 
  choose("user_admin")
end

When /I click on "Change Name" for "(.+)"/ do |name|
  slot = Slot.where(fish_date_id: @test_date.id, label: name).first
  click_link("change_name_#{slot.id}")
end

When /I click on "Delete" for "(.+)"/ do |name|
  slot = Slot.where(fish_date_id: @test_date.id, label: name).first
  click_link("delete_#{slot.id}")
end
