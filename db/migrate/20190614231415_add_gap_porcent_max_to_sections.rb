class AddGapPorcentMaxToSections < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :gap_max, :integer
    add_column :sections, :recommendation_negative, :text
    add_column :sections, :recommendation_gap_max, :text
    add_column :sections, :recommendation_no_data, :text
  end
end
