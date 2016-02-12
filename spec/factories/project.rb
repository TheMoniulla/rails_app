FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "name#{n}" }
    sequence(:user) { create(:user) }
    active true
  end
end
