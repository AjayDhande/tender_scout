class CreateSearchMonitors < ActiveRecord::Migration[5.1]
  def change
    create_table :search_monitors do |t|
      t.string :title
      t.string :tenderTitle
      t.integer :countryList, array: true, default: []
      t.string :keywordList,  array: true, default: []
      t.integer :valueFrom
      t.integer :valueTo
      t.integer :codeList,    array: true, default: []
      t.integer :buyerList,   array: true, default: []
      t.integer :statusList,  array: true, default: []
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
