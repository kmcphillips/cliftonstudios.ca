FactoryGirl.define do
  factory :post do
    title "New gallery show"
    body "This show is going to be tops blooby!"
    association :member
  end
end
