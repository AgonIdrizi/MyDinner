FactoryBot.define do
  factory :user do
  	name {'Agon'}
    sequence(:email) {|n| "agon#{n}@agon.com"}
    password {"123456"}
  end
end