class AddIndicationsToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :indications, :text
  end
end
