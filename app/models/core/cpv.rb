class Core::Cpv < ApplicationRecord
  self.table_name = "core_cpvs"
  # has_and_belongs_to_many :tenders, join_table: 'core_tenders_cpvs', foreign_key: :cpv_id, association_foreign_key: :tender_id
  has_many :tender_cpvs
  has_many :tenders, through: :tender_cpvs

  def format_fields
    {
      cpv_codes: [code]
    }
  end

  def code_name
    'cpv'
  end
end
