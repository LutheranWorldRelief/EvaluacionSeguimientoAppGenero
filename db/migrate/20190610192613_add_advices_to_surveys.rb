class AddAdvicesToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :recommendation_one, :text
    add_column :surveys, :recommendation_two, :text
    add_column :surveys, :advice, :text
  end
end
