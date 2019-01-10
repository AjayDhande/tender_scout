class AddQuestionAndAnswerDateToTender < ActiveRecord::Migration[5.1]
  def change
    add_column :core_tenders, :questioning_deadline, :datetime
    add_column :core_tenders, :answering_deadline, :datetime
  end
end
