FactoryGirl.define do
  factory :document do
    name 'The Document'
    kind 'bylaw'
    association :member
    file_file_name 'file.pdf'
    file_file_size '12345'
    file_content_type 'application/pdf'
    file_updated_at '2013-09-01'
  end
end
