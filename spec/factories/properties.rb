# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :property, :class => 'Properties' do
    initialize_with { Properties.instance }
  end
end
