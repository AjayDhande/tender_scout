class AllowNullInTenderProcedureId < ActiveRecord::Migration[5.1]
  def change
    change_column :core_tenders, :procedure_id, :integer, :null => true
    change_column :core_tenders, :currency_id, :integer, :null => true
    change_column :core_tenders, :organization_id, :integer, :null => true
    change_column :core_tenders, :status_cd, :integer, :null => true
    change_column :core_tenders, :flagged_as_sme_friendly, :boolean, :null => true
    change_column :core_tenders, :flagged_as_vcs_friendly, :boolean, :null => true
    change_column :core_tenders, :tender_urls, :string, array: true, :null => true
    change_column :core_tenders, :delta, :boolean, :null => true
  end
end
