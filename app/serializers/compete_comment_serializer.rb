class CompeteCommentSerializer < ActiveModel::Serializer
  has_many :answers, class_name: 'CompeteAnswers', serializer: CompeteAnswerSerializer
  has_many :comments, serializer: CompeteCommentSerializer

  attributes :id, :message, :comments, :answers, :created_at, :updated_at

  def comments
    CompeteComment.where(parent_id: object.id).each do |comment|
      CompeteCommentSerializer.new(comment)
    end
  end

  def answers
    object.answers do |item|
      CompeteAnswerSerializer.new(item)
    end
  end
end
