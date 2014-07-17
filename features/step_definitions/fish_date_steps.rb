Given /test day is a legal date/ do
  s = Season.find(Properties.instance.current_season_id)
  @test_day = s.start_date + 10
end

Given /test day is a nonlegal date/ do
  s = Season.find(Properties.instance.current_season_id)
  @test_day = s.start_date - 10
end

Then /I should find test day in FishDates/ do
  expect(FishDate.find_by_day(@test_day)).to_not eq(nil)
end

Then /I should not find test day in FishDates/ do
  expect(FishDate.find_by_day(@test_day)).to eq(nil)
end

Given /I specify date as test day/ do
  Date::DATE_FORMATS[:month_only] ||= '%b'
  select(@test_day.to_formatted_s(:month_only), from: "date_month")
  select(@test_day.day, from: "date_day")
  select(@test_day.year, from: "date_year")
end
