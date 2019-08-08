class RemoveAdviceFromSurveys < ActiveRecord::Migration[5.2]
  def change
    remove_column :surveys, :advice, :text
  end
end
