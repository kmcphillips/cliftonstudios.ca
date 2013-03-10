FactoryGirl.define do
  factory :event do
    title "Pie Party"
    body "Come to the pie party."
    association :member
    starts_at "2012-01-01"
  end
end
