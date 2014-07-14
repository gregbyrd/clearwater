# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    firstname "MyString"
    lastname "MyString"
    email "MyString"
    phone "MyString"
    password_digest "MyString"
    purchased 1
    guests "MyText"
    admin false
  end
end
