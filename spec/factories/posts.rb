FactoryBot.define do
  factory :post do
    name {'テストを書く'}
    content {'Rspec&Capybara&FactoryBotを準備する'}
    association :user, factory: :admin_user
  end
end
