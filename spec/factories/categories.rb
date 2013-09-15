# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    name { Forgery(:lorem_ipsum).words(3) }
  end
end
