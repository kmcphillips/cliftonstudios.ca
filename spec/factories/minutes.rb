FactoryGirl.define do
  factory :minutes do
    description 'Some meeting minutes'
    recorded_at '2013-08-18 01:02:03'
    association :member
    file_file_name 'minutes.pdf'
    file_file_size '1234'
    file_content_type 'application/pdf'
    file_updated_at '2013-09-01'
  end
end

