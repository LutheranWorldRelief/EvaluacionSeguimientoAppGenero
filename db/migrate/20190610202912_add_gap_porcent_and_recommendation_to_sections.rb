class AddGapPorcentAndRecommendationToSections < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :gap_porcent, :integer
    add_column :sections, :recommendation, :text
  end
end
