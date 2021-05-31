class AddSurveyRefToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_reference :answers, :survey, foreign_key: true
  end
end
