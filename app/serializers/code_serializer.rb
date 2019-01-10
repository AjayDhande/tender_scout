class CodeSerializer < ActiveModel::Serializer
  attributes :id
  attributes :code
  attributes :description
  attributes :code_name
end
