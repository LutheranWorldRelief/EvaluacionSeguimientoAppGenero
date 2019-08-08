class AddSurveyToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :survey, :string
  end
end
