FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    password 'foobar'


    trait :admin do
      email User::ADMIN_EMAILS.first
    end

    trait :member1 do 
      organization_ids [1,2]
    end
    trait :member2 do 
      organization_ids [1,3]
    end
    trait :member3 do 
      organization_ids [2,3]
    end
  end
end