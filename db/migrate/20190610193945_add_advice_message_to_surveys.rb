class AddAdviceMessageToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :advice_message, :text
  end
end
