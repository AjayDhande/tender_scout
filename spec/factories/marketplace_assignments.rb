FactoryBot.define do
  factory :marketplace_assignment, class: 'Marketplace::Assignment' do
    assygmentable_type { "MyString" }
    assygmentable_id { 1 }
    user_id { 1 }
    collaboration_id { "MyString" }
  end
end
