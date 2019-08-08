class AddRecommendationToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :recommendation, :text
  end
end
