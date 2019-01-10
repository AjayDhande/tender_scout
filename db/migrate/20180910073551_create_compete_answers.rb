class CreateCompeteAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :compete_answers do |t|
      t.text :message, null: false
      t.integer :parent_id, null: true
      t.references :user, foreign_key: true
      t.references :compete_comment, foreign_key: true
      t.timestamps
    end
  end
end
