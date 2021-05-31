class AssignSurveyRefToAnswersFromPreviousValues < ActiveRecord::Migration[5.2]
  def up
    answers = Answer.select("survey").group("survey");
    answers.each do |ans|
      Answer.where(:survey => ans.survey).update_all(survey_id: ans.survey);
    end
  end

  def down
    Answer.update_all(survey_id: null)
  end
end
