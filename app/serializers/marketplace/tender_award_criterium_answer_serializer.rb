class Marketplace::TenderAwardCriteriumAnswerSerializer < ActiveModel::Serializer
  # attributes :id, :order, :title
  # has_many :award_criteries, serializer: Marketplace::TenderAwardCriteriumSerializer
  attributes :id, :pass_fail, :score, :closed, :created_at, :collaboration_id
  has_one :user, serializer: UserSerializer
end
