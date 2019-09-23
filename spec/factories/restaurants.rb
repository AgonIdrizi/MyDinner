FactoryBot.define do
  factory :restaurant do
    sequence(:name) {|n|"Restaurant #{n}"}
    sequence(:location) {|n| "Boulevard #{n}"}
    city {'Tetovo'}
    state { "N.Macedonia"}
  end
end