class AddSectionRefToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :section, foreign_key: true
  end
end
