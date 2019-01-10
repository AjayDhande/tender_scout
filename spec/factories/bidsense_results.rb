FactoryBot.define do
  factory :bidsense_result do
    budget { 1.5 }
    geography { 1.5 }
    subject { 1.5 }
    incumbent { 1.5 }
    time { 1.5 }
    buyer_related { 1.5 }
    profile { nil }
    tender { nil }
  end
end
