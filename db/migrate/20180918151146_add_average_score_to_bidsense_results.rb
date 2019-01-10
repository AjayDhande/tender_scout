class AddAverageScoreToBidsenseResults < ActiveRecord::Migration[5.1]
  def change
    add_column :bidsense_results, :average_score, :float
  end
end
