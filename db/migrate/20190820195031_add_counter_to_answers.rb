class AddCounterToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :counter, :integer
  end
end
