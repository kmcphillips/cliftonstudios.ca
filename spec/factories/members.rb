FactoryGirl.define do
  factory :member do
    name "Mister Member"
    phone "(204) 123-4567"
    alternate_phone nil
    address "123 Fake street"
    bio "A studio member"
    receive_emails true
    sequence(:email){|n| "example#{ n }@test.com" }
    website "http://www.example.com"
    admin false
    active true
    password_configured true
    renting true
    space_number "a"
    member_since_year "1990"
    system false
    contact_method "email"
    superuser false

    password "asdfasdf"
    password_confirmation "asdfasdf"
  end
end
