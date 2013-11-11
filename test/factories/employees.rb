FactoryGirl.define do
  factory :employee do
    sequence(:email) { |n| "employee_#{n}@example.com" }
    password 'password'
  end
end
