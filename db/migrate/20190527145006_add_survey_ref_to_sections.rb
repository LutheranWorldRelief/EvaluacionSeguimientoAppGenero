class AddSurveyRefToSections < ActiveRecord::Migration[5.2]
  def change
    add_reference :sections, :survey, foreign_key: true
  end
end
