class UsersIndex < Chewy::Index
  settings analysis: {
    tokenizer: {
      customNgram: {
        min_gram: "3",
        type: "nGram",
        max_gram: "15"
      }
    },
    filter: {
      custom_word_delimiter: {
        type: 'word_delimiter',
        generate_word_parts: true,    # "PowerShot" => "Power" "Shot", части одного слова становятся отдельными токенами
        generate_number_parts: true,  # "500-42" => "500" "42"
        catenate_words: false,        # "wi-fi" => "wifi"
        catenate_numbers: false,      # "500-42" => "50042"
        catenate_all: false,          # "wi-fi-4000" => "wifi4000"
        split_on_case_change: true,   # "PowerShot" => "Power" "Shot"
        preserve_original: false,     # "500-42" => "500-42" "500" "42"
        split_on_numerics: true       # "j2se" => "j" "2" "se"
      },
      email: {
        type: :pattern_capture,
        preserve_original: 1,
        patterns: [
          "([^@]+)",
          "(\\p{L}+)",
          "(\\d+)",
          "@(.+)",
          "([^-@]+)"
        ]
      },
      fullname: {
        type:     :ngram,
        min_gram: 3,
        max_gram: 10
      },
    },
    analyzer: {
      split_tokens: {
        tokenizer: :letter,
        filter: [:lowercase],
      },
      fullname: {
        tokenizer: :customNgram,
        filter: [
          :lowercase
        ]
      },
      fullname_search: {
        tokenizer: :letter,
        filter: [
          :lowercase
        ]
      }

    }
  }
  define_type User.all do
    field :email, value: -> (user) { user.email }, analyzer: :fullname
    field :fullname, value: -> (user) { user.profiles.try(:first).try(:fullname) }, analyzer: :fullname
    # field :created_at, type: 'date', value: ->{ created_at } 
    # field :country_id, value: ->(tender) { tender.try(:country).try(:id) }
    # field :low_value, value: ->(tender) { tender.estimated_low_value.to_i }, type: :integer
    # field :high_value, value: ->(tender) { tender.estimated_high_value.to_i }, type: :integer
  end
end