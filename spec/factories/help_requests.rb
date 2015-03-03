FactoryGirl.define do
  factory :help_request do
    description Faker::Lorem.paragraph
    is_complete false
  end
end
