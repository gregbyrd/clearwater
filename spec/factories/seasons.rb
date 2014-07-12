# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :season do
    year 2014
    start_month 10
    end_month 4
    slot_limit 8
  end
end
