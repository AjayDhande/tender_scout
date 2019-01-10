class TendersIndex < Chewy::Index
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

  define_type Core::Tender.with_relations do
    witchcraft!
    field :title, value: -> (tender) { tender.title }
    field :description, value: -> (tender) { (tender.description.gsub(/[^0-9A-Za-z \t]/i, '').gsub(/\t/,' ') rescue '') }
    field :created_at, type: 'date', value: -> (tender) { tender.created_at }
    field :awarded_on, type: 'date', value: -> (tender) { tender.awarded_on }
    field :cancelled_on, type: 'date', value: -> (tender) { tender.cancelled_on }
    field :submission_date, type: 'date', value: -> (tender) { tender.submission_date }
    field :country_id, value: ->(tender) { tender.try(:country).try(:id) }
    field :low_value, value: ->(tender) { tender.estimated_low_value.to_i }, type: :integer
    field :high_value, value: ->(tender) { tender.estimated_high_value.to_i }, type: :integer
    field :ic_nuts_codes, value: -> (tender) {tender.nuts_codes}
    field :ic_cpvs, value: ->(tender) { tender.try(:cpvs).try(:ids) }
    field :ic_naicses, value: -> (tender) { tender.try(:naicses).try(:ids) }
    field :ic_ngips, value: -> (tender) { tender.try(:ngips).try(:ids) }
    field :ic_unspsces, value: -> (tender) { tender.try(:unspsces).try(:ids) }
    field :ic_gsins, value: -> (tender) { tender.try(:gsins).try(:ids) }
    field :ic_nhs_e_classes, value: -> (tender) { tender.try(:nhs_e_classes).try(:ids) }
    field :ic_pro_classes, value: -> (tender) { tender.try(:pro_classes).try(:ids) }
    field :buyers, value: -> (tender) {
        tender.try(:organization).try(:name) || tender.try(:creator).try(:profiles).try(:first).try(:fullname)
    }, analyzer: :fullname
  end
end