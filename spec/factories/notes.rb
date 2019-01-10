FactoryBot.define do
  factory :note do
    notable_type { "MyString" }
    notable_id { 1 }
    user_id { 1 }
    body { "MyText" }
  end
end
