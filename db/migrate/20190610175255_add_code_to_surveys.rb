class AddCodeToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :code, :string
  end
end
