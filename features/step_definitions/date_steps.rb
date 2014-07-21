Given /the following dates exist/ do |date_table|
  date_table.hashes.each do |date|
    if date[:season]
      season = Season.find_by_year(date[:season])
    else
      season = Season.find(Properties.instance.current_season_id)
    end
    FactoryGirl.create(:fish_date,
                       day: Date.parse(date[:date]),
                       season: season,
                       slot_limit: date[:slots] || 8)
  end
end
