FactoryGirl.define do
  factory :help_request do
    association :student, factory: :student
    association :ta_user, factory: :ta_user
    description Faker::Lorem.paragraph
    is_complete false
  end
end
