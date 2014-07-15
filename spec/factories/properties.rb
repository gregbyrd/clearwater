# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :property, :class => 'Properties' do
    current_season_id 1
  end
end
