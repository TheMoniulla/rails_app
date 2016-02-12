FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "first_name#{n}@last_name.com" }
    sequence(:first_name) { |n| "first_name_#{n}" }
    sequence(:last_name) { |n| "last_name_#{n}" }
  end
end