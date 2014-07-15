# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    firstname "John"
    lastname "Doe"
    email "jd@gmail.com"
    phone "919-555-5555"
    password "abc"
    purchased 0
    admin false

    trait :admin do
      admin true
    end

  end
end
