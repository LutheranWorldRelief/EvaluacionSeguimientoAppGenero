class AddDicardQuestionToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :discard_question, :string
  end
end
