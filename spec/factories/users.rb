FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    password 'foobar'

    trait :admin do
      email User::ADMIN_EMAILS.first
    end
  end
end