FactoryGirl.define do 
  factory :user do
    sequence :email do |n|
      "test#{n}@test.com"
    end
    password "1234abcd"
    password_confirmation "1234abcd"
  end

  factory :place do 
    name "Bob's Pizza"
    address "2233 Delkus Crescent, Mississauga, Ontario L5A 1K8"
    description "Awesome pizza!"
    association :user
  end

  factory :comment do
    rating '3_stars'
    association :user
    association :place
  end
end