class RemoveCodeFromSections < ActiveRecord::Migration[5.2]
  def change
    remove_column :sections, :code, :string
  end
end
