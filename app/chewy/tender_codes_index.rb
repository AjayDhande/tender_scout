class TenderCodesIndex < Chewy::Index
  settings analysis: {
    tokenizer: {
      customNgram: {
        min_gram: "3",
        type: "nGram",
        max_gram: "15"
      }
    },
    filter: {
      
    },
    analyzer: {
      code: {
        tokenizer: :customNgram,
        filter: [
          :lowercase
        ]
      }
    }
  }

  define_type Core::ClassificationCode.all do
    field :id, value: -> (industry_code) { industry_code.id }
    field :description, value: -> (industry_code) { industry_code.description }
    field :code, analyzer: :code, value: ->{ code } 
    field :code_name, value: ->(industry_code) { industry_code.code_name }
  end
  define_type Core::Gsin.all do
    field :id, value: -> (industry_code) { industry_code.id }
    field :description, value: -> (industry_code) { industry_code.description }
    field :code, analyzer: :code, value: ->{ code } 
    field :code_name, value: ->(industry_code) { industry_code.code_name }
  end
  define_type Core::Ngip.all do
    field :id, value: -> (industry_code) { industry_code.id }
    field :description, value: -> (industry_code) { industry_code.description }
    field :code, analyzer: :code, value: ->{ code } 
    field :code_name, value: ->(industry_code) { industry_code.code_name }
  end
  define_type Core::Sfgov.all do
    field :id, value: -> (industry_code) { industry_code.id }
    field :description, value: -> (industry_code) { industry_code.description }
    field :code, analyzer: :code, value: ->{ code } 
    field :code_name, value: ->(industry_code) { industry_code.code_name }
  end
  define_type Core::Naics.all do
    field :id, value: -> (industry_code) { industry_code.id }
    field :description, value: -> (industry_code) { industry_code.description }
    field :code, analyzer: :code, value: ->{ code } 
    field :code_name, value: ->(industry_code) { industry_code.code_name }
  end
  define_type Core::Cpv.all do
    field :id, value: -> (industry_code) { industry_code.id }
    field :description, value: -> (industry_code) { industry_code.description }
    field :code, analyzer: :code, value: ->{ code } 
    field :code_name, value: ->(industry_code) { industry_code.code_name }
  end
  define_type Core::ProClass.all do
    field :id, value: -> (industry_code) { industry_code.id }
    field :description, value: -> (industry_code) { industry_code.description }
    field :code, analyzer: :code, value: ->{ code } 
    field :code_name, value: ->(industry_code) { industry_code.code_name }
  end
  define_type Core::NhsEClass.all do
    field :id, value: -> (industry_code) { industry_code.id }
    field :description, value: -> (industry_code) { industry_code.description }
    field :code, analyzer: :code, value: ->{ code } 
    field :code_name, value: ->(industry_code) { industry_code.code_name }
  end
  define_type Core::Unspsc.all do
    field :id, value: -> (industry_code) { industry_code.id }
    field :description, value: -> (industry_code) { industry_code.description }
    field :code, analyzer: :code, value: ->{ code } 
    field :code_name, value: ->(industry_code) { industry_code.code_name }
  end

end