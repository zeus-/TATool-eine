FactoryGirl.define do
  factory :ta_user do
    sequence(:email) {|n| "valid_email#{n}@outlook.com" }
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password Faker::Internet.password(12)
  end

end
